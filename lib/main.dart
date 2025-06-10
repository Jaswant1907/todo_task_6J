import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_task_6j/screens/home_page.dart';
import 'package:notes_app_task_6j/widgets/check_box.dart';
//import 'package:notes_app_task_6j/widgets/notes_list_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:notes_app_task_6j/widgets/drop_down.dart';
//import 'package:notes_app_task_6j/widgets/check_box_filter_demo.dart';
//import 'package:notes_app_task_6j/widgets/filter_notes.dart';


import 'model/notes_model.dart';


ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Notes App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          home: const HomePage(),
        );
      },
    );
  }
}
