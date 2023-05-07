import 'package:btliot/data/cache_manager.dart';
import 'package:btliot/data/model/board_local/board_model.dart';
import 'package:btliot/ui/board/cubit/broad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class BroadCubit extends Cubit<BroadState> {
  BroadCubit() : super(BroadState.initial());

  final _cacheManager = CacheManager.instance;
  void init() async {
    List<BoardModelLocal> dataLocal = await _cacheManager.getAllBoard();
    emit(state.copyWith(listBoardLocal: dataLocal));
  }

  Future<void> setStatus(BoardModelLocal boardModelLocal) async {
    _cacheManager.addBoardToCache(
        boardModelLocal.copyWith(isEnable: !boardModelLocal.isEnable!));
    init();
  }
}
