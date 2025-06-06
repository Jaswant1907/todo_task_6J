  import 'package:flutter/material.dart';
  import 'package:hive/hive.dart';
  import 'package:hive_flutter/hive_flutter.dart';
  import 'package:notes_app_task_6j/box/Boxes.dart';
  import 'package:notes_app_task_6j/dialogue_box/add_dialogue.dart';
  import 'package:notes_app_task_6j/widgets/drop_down.dart';
  import 'package:notes_app_task_6j/model/notes_model.dart';
  import 'package:notes_app_task_6j/widgets/check_box.dart';
  import 'package:notes_app_task_6j/widgets/notes_list_view.dart';

  class HomePage extends StatefulWidget {
   // final NotesModel notesModel;
    const HomePage({super.key,});

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    //late<NotesModel>notesbox;

    void delete(NotesModel notesModel) async {
      await notesModel.delete();
    }

    // void addTask(NotesModel notesmodel,String title,String desc,) async{
    //
    //   notesmodel.title = title;
    //   notesmodel.desc  = desc;
    //
    // }
    //
    // void add(String titles, String info) {
    //   final data = NotesModel(title: titles, desc: info);
    //   notesbox.add(data);
    // }
    //
    // void initState() {
    //   notesbox = Hive.box<NotesModel>('notes');
    // }

    //final NotesModel notesModel;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text("Notes App"),
          actions: [
            DropDown()
          ],
          //    centerTitle: true,
         backgroundColor: Colors.white54,
        ),
        body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getToDoData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final data1 = data[index];
                return Dismissible(
                  key: Key(data1.title.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white,),

                  ),
                  onDismissed: (_) => delete(data1),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 11

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(data[index].title.toString()),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(onPressed: () {
                                    AddDialogue.editTaskDialogue(context,data1,index);

                                  }, icon: Icon(Icons.edit)),
                                  SizedBox(width: 10,),
                                  CheckBoxWidget()
                                ],
                              )
                              // AddDeletIcon()
                            ],
                          ),
                          Text(data[index].desc.toString())
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          AddDialogue.addTaskDialogue(context,);
        }, child: Icon(Icons.add),),
        //
        //
        //


      );
    }

  }

