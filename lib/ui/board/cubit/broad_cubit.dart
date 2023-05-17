import 'package:btliot/data/cache_manager.dart';
import 'package:btliot/data/model/board_local/board_model.dart';
import 'package:btliot/ui/board/cubit/broad_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workmanager/workmanager.dart';

class BroadCubit extends Cubit<BroadState> {
  BroadCubit() : super(BroadState.initial());

  final _cacheManager = CacheManager.instance;
  final simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
  void init() async {
    List<BoardModelLocal> dataLocal = await _cacheManager.getAllBoard();
    Workmanager()
        .initialize(
      callbackDispatcher,
      isInDebugMode: true,
    )
        .then((value) {
      Workmanager().registerOneOffTask(
        simpleTaskKey,
        simpleTaskKey,
        inputData: <String, dynamic>{
          'int': 1,
          'bool': true,
          'double': 1.0,
          'string': 'string',
          'array': [dataLocal.map((e) => e.toJson()).toList()],
        },
      );
    });

    emit(state.copyWith(listBoardLocal: dataLocal));
  }

  Future<void> setStatus(BoardModelLocal boardModelLocal) async {
    _cacheManager.addBoardToCache(
        boardModelLocal.copyWith(isEnable: !boardModelLocal.isEnable!));
    init();
  }
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      var dataLocal = inputData?["array"] as List<dynamic>;
      dataLocal;
    } catch (e) {
      e;
    }

    return Future.value(true);
  });
}
