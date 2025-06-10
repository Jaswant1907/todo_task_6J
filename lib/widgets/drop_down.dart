import 'package:flutter/material.dart';


const List<String> dropList = ['All','Completed','inCompleted'];


class DropDown extends StatefulWidget {

  final Function(String) onChanged;
  const DropDown({super.key,required this.onChanged});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String firstList = dropList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
          value: firstList,
          icon: Icon(Icons.keyboard_arrow_down),
          elevation: 16,
          style: TextStyle(color: Colors.purple),
          underline: Container(height: 2,color: Colors.white54,),

          onChanged: (String? value){
            if(value != null) {
              setState(() {
                firstList = value!;
              });

              widget.onChanged(value);
            }
          },

          items: dropList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList(),
    );
  }
}

