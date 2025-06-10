import 'package:flutter/material.dart';
import 'package:notes_app_task_6j/dialogue_box/add_dialogue.dart';
import 'package:notes_app_task_6j/model/notes_model.dart';

class CheckBoxWidget extends StatefulWidget {

  final NotesModel note;

  const CheckBoxWidget({super.key,required this.note});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
 // bool isChecked = false;



  @override
  Widget build(BuildContext context) {
   // var data =
   Color getColor(Set<WidgetState> states){
     const Set<WidgetState> interactiveStates = <WidgetState>{
       WidgetState.pressed,
       WidgetState.hovered,
       WidgetState.focused
     };
     if(states.any(interactiveStates.contains)){
       return Colors.blue;
     }
     return Colors.grey;
   }


    return Checkbox(
      value: widget.note.isDone,
      checkColor: Colors.white,
      fillColor: WidgetStateColor.resolveWith(getColor),

      onChanged: (bool? value) {
            setState(() {
              widget.note.isDone =  value!;
              widget.note.save();
            });
      },);
  }
}

