import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:demoios/cubit/main_state.dart';
import 'package:demoios/data/cache_manager.dart';
import 'package:demoios/data/model/board_local/board_model.dart';
import 'package:demoios/ui/connect_host/connect_host.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState.initial());

  final _cacheManager = CacheManager.instance;
  late Timer? _timer = null;
  void initdata() async {
    print("giang push mess LED1 - 0");
    // pushMess("LED1", "0");
    print("giang push mess LED1 - 0");
    _manageMQTT();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      _manageMQTT();
      // });
    });
  }

  Future<void> _manageMQTT() async {
    pushMess("LED1", "0");
    // print("giang push mess LED1 - 0");
    List<BoardModelLocal> dataLocal = await _cacheManager.getAllBoard();
    dataLocal = dataLocal.map((e) {
      DateTime now = DateTime.now();
      var hnow = now.hour;
      var mnow = now.minute;
      int hModel = (e.timeDuration! / 60).toInt();
      int mModel = e.timeDuration! % 60;
      int secondNow = hnow * 3600 + mnow * 60;
      int secondModel = hModel * 3600 + mModel * 60;
      if (e.isEnable == true &&
          secondNow > secondModel &&
          client.connectionStatus!.state == MqttConnectionState.connected) {
        switch (e.model) {
          //"Đèn", "Quạt", "Cửa sổ"
          //"Tắt", "Mở", "Tự động"
          case "Đèn":
            if (e.statusModel == "Tắt") {
              pushMess("LED1", "0");
            } else if (e.statusModel == "Mở") {
              pushMess("LED1", "1");
            } else {}
            break;
          case "Quạt":
            if (e.statusModel == "Tắt") {
              pushMess("FAN", "0");
            } else if (e.statusModel == "Mở") {
              pushMess("FAN", "1");
            } else {
              pushMess("AFAN", "1");
            }
            break;
          case "Cửa sổ":
            if (e.statusModel == "Tắt") {
              pushMess("DOOR", "0");
            } else if (e.statusModel == "Mở") {
              pushMess("DOOR", "1");
            } else {
              pushMess("ADOOR", "1");
            }
            break;
        }

        return e.copyWith(isEnable: false);
      } else
        return e;
    }).toList();
    _cacheManager.addAllBoard(dataLocal);
  }
}
