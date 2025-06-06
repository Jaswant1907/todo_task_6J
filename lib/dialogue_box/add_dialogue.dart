import 'package:flutter/material.dart';
import 'package:notes_app_task_6j/box/Boxes.dart';
import 'package:notes_app_task_6j/model/notes_model.dart';

class AddDialogue {


  static Future<void> addTaskDialogue(BuildContext context,) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,

                decoration: InputDecoration(
                    hintText: 'Enter task',
                    border: OutlineInputBorder()
                ),


              ),
              SizedBox(height: 15,),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    hintText: 'Enter description',
                    border: OutlineInputBorder()
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text('cancel')),
            TextButton(onPressed: () {
              if (titleController.text.isNotEmpty) {
                final data = NotesModel(
                    title: titleController.text,
                    desc: descController.text,
                    isDone: false
                );

                final box = Boxes.getToDoData();
                box.add(data);

                titleController.clear();
                descController.clear();
                Navigator.pop(context);
              };
            }, child: Text('Add'))
          ],
        );
      },
    );
  }

  static Future<void> editTaskDialogue(BuildContext context, NotesModel note,
      int index) {
    TextEditingController titleController = TextEditingController(
        text: note.title);
    TextEditingController descController = TextEditingController(
        text: note.desc);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter task',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  note.title = titleController.text;
                  note.desc = descController.text;
                  note.save(); // This updates the Hive record

                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
