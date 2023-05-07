import 'dart:typed_data';

import 'package:btliot/data/cache_manager.dart';
import 'package:hive/hive.dart';

part 'board_model.g.dart';

@HiveType(typeId: CacheManager.broadmodel)
class BoardModelLocal extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime time;
  @HiveField(3)
  final List<Uint8List>? listImage;

  BoardModelLocal({
    this.id,
    required this.title,
    required this.time,
    this.listImage,
  });

  BoardModelLocal copyWith(
      {String? id, String? title, DateTime? time, List<Uint8List>? listImage}) {
    return BoardModelLocal(
        id: id ?? this.id,
        title: title ?? this.title,
        time: time ?? this.time,
        listImage: listImage ?? this.listImage);
  }
}
