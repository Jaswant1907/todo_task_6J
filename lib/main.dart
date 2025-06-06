import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_task_6j/screens/home_page.dart';
import 'package:notes_app_task_6j/widgets/check_box.dart';
import 'package:notes_app_task_6j/widgets/notes_list_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:notes_app_task_6j/widgets/drop_down.dart';


import 'model/notes_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());

  await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

