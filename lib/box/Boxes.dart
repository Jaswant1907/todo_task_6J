import 'package:hive/hive.dart';
import 'package:notes_app_task_6j/model/notes_model.dart';

class Boxes{

  static Box<NotesModel> getToDoData() => Hive.box<NotesModel>('notes');
}