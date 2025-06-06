import 'package:flutter/material.dart';
import 'package:notes_app_task_6j/widgets/check_box.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Text('Name'),
                Spacer(),
                CheckBoxWidget()
              ],
            ),
            subtitle: Text('Surname'),
          );
      },
    );
  }
}
