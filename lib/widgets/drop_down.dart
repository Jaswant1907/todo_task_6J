import 'package:flutter/material.dart';


const List<String> dropList = ['All','Completed','inCompleted'];


class DropDown extends StatefulWidget {
  const DropDown({super.key});

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
          underline: Container(height: 2,color: Colors.green,),

          onChanged: (String? value){
            setState(() {
              firstList = value!;
            });


          },

          items: dropList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList(),
    );
  }
}

// enum Filter {all, comleted, incompleted}
//
// Filter currentFilter = Filter.all;
//
// List<dropList> get filteredTodos {
//
//   switch(currentFilter){
//
//     case Filter.comleted :
//       return  currentFilter.where((todo) => todo.)
//   }
//
//
// }

