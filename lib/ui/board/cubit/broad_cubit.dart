import 'dart:async';

import 'package:workmanager_example/data/cache_manager.dart';
import 'package:workmanager_example/data/model/board_local/board_model.dart';
import 'package:workmanager_example/ui/board/cubit/broad_state.dart';
import 'package:workmanager_example/ui/board/cubit/conect2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_example/ui/connect_host/connect_host.dart';

class BroadCubit extends Cubit<BroadState> {
  BroadCubit() : super(BroadState.initial());

  final _cacheManager = CacheManager.instance;
  late Timer? _timer = null;
  final simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";

  void init() async {
    // if (_timer != null) _timer!.cancel();
    List<BoardModelLocal> dataLocal = await _cacheManager.getAllBoard();
    dataLocal = dataLocal.map((e) {
      DateTime now = DateTime.now();
      var hnow = now.hour;
      var mnow = now.minute;
      int hModel = (e.timeDuration! / 60).toInt();
      int mModel = e.timeDuration! % 60;
      int secondNow = hnow * 3600 + mnow * 60;
      int secondModel = hModel * 3600 + mModel * 60;
      if (e.isEnable == true && secondNow > secondModel) {
        return e.copyWith(isEnable: false);
      } else
        return e;
    }).toList();
    emit(state.copyWith(listBoardLocal: dataLocal));

    // _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
    //   dataLocal = await _cacheManager.getAllBoard();
    //   dataLocal = dataLocal.map((e) {
    //     DateTime now = DateTime.now();
    //     var hnow = now.hour;
    //     var mnow = now.minute;
    //     int hModel = (e.timeDuration! / 60).toInt();
    //     int mModel = e.timeDuration! % 60;
    //     int secondNow = hnow * 3600 + mnow * 60;
    //     int secondModel = hModel * 3600 + mModel * 60;
    //     if (e.isEnable == true && secondNow > secondModel) {
    //       return e.copyWith(isEnable: false);
    //     } else
    //       return e;
    //   }).toList();
    //   _cacheManager.addAllBoard(dataLocal);
    //   emit(state.copyWith(listBoardLocal: dataLocal));
    // });

    // Workmanager().cancelAll();
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    Timer(Duration(seconds: 3), () {
      Workmanager().registerOneOffTask(simpleTaskKey, simpleTaskKey,
          inputData: <String, dynamic>{
            'int': 1,
            'bool': true,
            'double': 1.0,
            'string': 'string',
            'array': ["LED1", "0"], //dataLocal.map((e) => e.toJson()).toList(),
          });
      Workmanager().registerOneOffTask(simpleTaskKey, simpleTaskKey,
          initialDelay: Duration(seconds: 10),
          inputData: <String, dynamic>{
            'int': 1,
            'bool': true,
            'double': 1.0,
            'string': 'string',
            'array': ["LED1", "0"], //dataLocal.map((e) => e.toJson()).toList(),
          });
    });

    // for (BoardModelLocal i in dataLocal) {
    //   DateTime now = DateTime.now();
    //   var hnow = now.hour;
    //   var mnow = now.minute;
    //   int hModel = (i.timeDuration! / 60).toInt();
    //   int mModel = i.timeDuration! % 60;
    //   int secondNow = hnow * 3600 + mnow * 60;
    //   int secondModel = hModel * 3600 + mModel * 60;
    //   int time;
    //   if (secondNow < secondModel) {
    //     time = secondModel - secondNow;
    //   } else {
    //     time = secondModel + 24 * 3600 - secondNow;
    //   }
    //   if (i.isEnable == true) {
    //     switch (i.model) {
    //       //"Đèn", "Quạt", "Cửa sổ"
    //       //"Tắt", "Mở", "Tự động"
    //       case "Đèn":
    //         if (i.statusModel == "Tắt") {
    //           Workmanager().registerOneOffTask(simpleTaskKey, simpleTaskKey,
    //               initialDelay: Duration(seconds: time),
    //               inputData: <String, dynamic>{
    //                 'int': 1,
    //                 'bool': true,
    //                 'double': 1.0,
    //                 'string': 'string',
    //                 'array': [
    //                   "LED1",
    //                   "0"
    //                 ], //dataLocal.map((e) => e.toJson()).toList(),
    //               });
    //         } else if (i.statusModel == "Mở") {
    //           Workmanager().registerOneOffTask(
    //             simpleTaskKey,
    //             simpleTaskKey,
    //             initialDelay: Duration(seconds: time),
    //             inputData: <String, dynamic>{
    //               'int': 1,
    //               'bool': true,
    //               'double': 1.0,
    //               'string': 'string',
    //               'array': [
    //                 "LED1",
    //                 "1"
    //               ], //dataLocal.map((e) => e.toJson()).toList(),
    //             },
    //           );
    //         } else {}
    //         break;
    //       case "Quạt":
    //         if (i.statusModel == "Tắt") {
    //           Workmanager().registerOneOffTask(simpleTaskKey, simpleTaskKey,
    //               initialDelay: Duration(seconds: time),
    //               inputData: <String, dynamic>{
    //                 'int': 1,
    //                 'bool': true,
    //                 'double': 1.0,
    //                 'string': 'string',
    //                 'array': [
    //                   "FAN",
    //                   "0"
    //                 ], //dataLocal.map((e) => e.toJson()).toList(),
    //               });
    //         } else if (i.statusModel == "Mở") {
    //           Workmanager().registerOneOffTask(
    //             simpleTaskKey,
    //             simpleTaskKey,
    //             initialDelay: Duration(seconds: time),
    //             inputData: <String, dynamic>{
    //               'int': 1,
    //               'bool': true,
    //               'double': 1.0,
    //               'string': 'string',
    //               'array': [
    //                 "FAN",
    //                 "1"
    //               ], //dataLocal.map((e) => e.toJson()).toList(),
    //             },
    //           );
    //         } else {
    //           Workmanager().registerOneOffTask(
    //             simpleTaskKey,
    //             simpleTaskKey,
    //             initialDelay: Duration(seconds: time),
    //             inputData: <String, dynamic>{
    //               'int': 1,
    //               'bool': true,
    //               'double': 1.0,
    //               'string': 'string',
    //               'array': [
    //                 "AFAN",
    //                 "1"
    //               ], //dataLocal.map((e) => e.toJson()).toList(),
    //             },
    //           );
    //         }
    //         break;
    //       case "Cửa sổ":
    //         if (i.statusModel == "Tắt") {
    //           Workmanager().registerOneOffTask(simpleTaskKey, simpleTaskKey,
    //               initialDelay: Duration(seconds: time),
    //               inputData: <String, dynamic>{
    //                 'int': 1,
    //                 'bool': true,
    //                 'double': 1.0,
    //                 'string': 'string',
    //                 'array': [
    //                   "DOOR",
    //                   "0"
    //                 ], //dataLocal.map((e) => e.toJson()).toList(),
    //               });
    //         } else if (i.statusModel == "Mở") {
    //           Workmanager().registerOneOffTask(
    //             simpleTaskKey,
    //             simpleTaskKey,
    //             initialDelay: Duration(seconds: time),
    //             inputData: <String, dynamic>{
    //               'int': 1,
    //               'bool': true,
    //               'double': 1.0,
    //               'string': 'string',
    //               'array': [
    //                 "DOOR",
    //                 "1"
    //               ], //dataLocal.map((e) => e.toJson()).toList(),
    //             },
    //           );
    //         } else {
    //           Workmanager().registerOneOffTask(
    //             simpleTaskKey,
    //             simpleTaskKey,
    //             initialDelay: Duration(seconds: time),
    //             inputData: <String, dynamic>{
    //               'int': 1,
    //               'bool': true,
    //               'double': 1.0,
    //               'string': 'string',
    //               'array': [
    //                 "ADOOR",
    //                 "1"
    //               ], //dataLocal.map((e) => e.toJson()).toList(),
    //             },
    //           );
    //         }
    //         break;
    //     }
    //   }
    // }
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
    var dataLocal = inputData?["array"] as List<dynamic>;

    dataLocal;

    concectBroker(
      disconnect: () {},
      connect: () {},
    );
    Timer(Duration(seconds: 1), () {
      pushMess("LED1", "0");
    });

    return Future.value(true);
  });
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher2() {
  Workmanager().executeTask((task, inputData) async {
    print("giangtest124");

    return Future.value(true);
  });
}
