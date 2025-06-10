

import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{

  @HiveField(0)
  String title;

  @HiveField(1)
  String desc;

  @HiveField(2)
  bool isDone;

  // @HiveField(3)
  // DateTime dateTime;
  //
  // @HiveField(4)
  // int priority;

  NotesModel({required this.title ,required this.desc, this.isDone = false});



}