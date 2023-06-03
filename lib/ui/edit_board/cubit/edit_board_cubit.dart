import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demoios/data/cache_manager.dart';
import 'package:demoios/data/model/board_local/board_model.dart';
import 'package:demoios/ui/edit_board/cubit/edit_board_state.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:path/path.dart' as p;

class EditBoardCubit extends Cubit<EditBoardState> {
  EditBoardCubit() : super(EditBoardState.initial());

  final _cacheManager = CacheManager.instance;
  List<Uint8List> imageFileList = [];
  handlePickImage() async {
    // isLoadingUpdateImage(true);
  }

  void init(BoardModelLocal? boardModelLocal) async {
    if (boardModelLocal != null) {
      emit(state.copyWith(
          boardModelLocal: boardModelLocal,
          title: boardModelLocal.title,
          day: boardModelLocal.time,
          imageFileList: boardModelLocal.listImage ?? []));
    }
  }

  void setDay(DateTime day) {
    emit(state.copyWith(day: day));
  }

  getFromCamera() async {}

  deleteImage(int index) {
    List<Uint8List> a = [];
    for (int i = 0; i < state.imageFileList.length; i++) {
      if (i != index) {
        a.add(state.imageFileList[i]);
      }
    }
    emit(state.copyWith(imageFileList: a));
  }

  void save(
      {required String title,
      String? content,
      required DateTime time,
      required String model,
      required Duration timeDuration,
      required String statusModel}) async {
    if (state.boardModelLocal != null) {
      _cacheManager.addBoardToCache(BoardModelLocal(
          id: state.boardModelLocal!.id,
          title: title,
          time: time,
          model: model,
          timeDuration: timeDuration.inMinutes,
          statusModel: statusModel,
          listImage: state.imageFileList));
    } else {
      _cacheManager.addBoardToCache(BoardModelLocal(
        title: title,
        time: time,
        listImage: state.imageFileList,
        model: model,
        timeDuration: timeDuration.inMinutes,
        statusModel: statusModel,
      ));
    }
  }
}
