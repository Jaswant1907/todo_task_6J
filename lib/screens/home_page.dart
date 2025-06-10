import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_task_6j/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app_task_6j/box/Boxes.dart';
import 'package:notes_app_task_6j/dialogue_box/add_dialogue.dart';
import 'package:notes_app_task_6j/widgets/drop_down.dart';
import 'package:notes_app_task_6j/model/notes_model.dart';
import 'package:notes_app_task_6j/widgets/check_box.dart';
// import 'package:notes_app_task_6j/widgets/notes_list_view.dart';

class HomePage extends StatefulWidget {
  // final NotesModel notesModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  String selectedFilter = 'All';

  //late<NotesModel>notesbox;

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Notes App"),
        actions: [
          DropDown(
            onChanged: (value) {
              setState(() {
                selectedFilter = value;
              });
            },
          ),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              themeNotifier.value =
                  themeNotifier.value == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark;
            },
          ),
          SizedBox(width: 5),
        ],
        //    centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getToDoData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();

          var filtereData =
              data.where((task) {
                final checked = task.isDone == true;
                switch (selectedFilter) {
                  case 'Completed':
                    return checked == true;

                  case 'inCompleted':
                    return checked == false;

                  default:
                    return true;
                }
              }).toList();

          return filtereData.isEmpty
              ? Center(child: Text('No tasks available'))
              : ListView.builder(
                itemCount: filtereData.length,
                itemBuilder: (context, index) {
                  final data1 = filtereData[index];
                  return Dismissible(
                    key: Key(data1.title.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),

                    onDismissed: (direction) async {
                      final deletedItem = data1;

                      final box = Boxes.getToDoData();

                      await deletedItem.delete();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${deletedItem.title} deleted"),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () async {
                              await box.add(deletedItem);
                            },
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },

                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 11,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(data1.title.toString()),
                                Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        AddDialogue.editTaskDialogue(
                                          context,
                                          data1,
                                          index,
                                        );
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    SizedBox(width: 10),
                                    CheckBoxWidget(note: data1),
                                  ],
                                ),
                              ],
                            ),
                            Text(data1.desc.toString()),
                            Text('date : 08/10/2021'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddDialogue.addTaskDialogue(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

