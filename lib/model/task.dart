class Task{

  String title;
  bool isDone;
  DateTime? dueDate;
  int? priotity;

  Task({required this.title, this.isDone = false, this.dueDate,this.priotity});

}

DropdownButton<int>(
      value: _selectedPriority,
        items: [
            DropdownMenuItem(value: 1, child: Text("High")),
            DropdownMenuItem(value: 2, child: Text("Medium")),
            DropdownMenuItem(value: 3, child: Text("Low")),
        ],
   onChanged: (value) => setState(() => _selectedPriority = value),
  );


tasks.sort((a, b) {
    // Sort by due date first, then priority
        if (a.dueDate != null && b.dueDate != null) {
           return a.dueDate!.compareTo(b.dueDate!);
        } else if (a.dueDate == null) {
             return 1;
        } else if (b.dueDate == null) {
             return -1;
        } else {
               return a.priority!.compareTo(b.priority!);
        }
});
