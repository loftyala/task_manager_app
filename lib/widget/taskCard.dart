import 'package:flutter/material.dart';
class taskCard extends StatefulWidget {
  const taskCard({
    super.key,
  });

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title of the Task",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text("Description of the TaskDescription of the TaskDescription of the TaskDescription of the TaskDescription of the Task ",
              style: Theme.of(context).textTheme.titleSmall),
          Text("Date: 01-01-2023"),
          Row(
            children: [
              _TaskStatusChip(),

              Spacer(),
              IconButton(onPressed: () {
                _onTapEditButton();
              }, icon: Icon(Icons.edit_note,color: Colors.deepOrange,)),
              IconButton(onPressed: () {

              }, icon: Icon(Icons.delete,color: Colors.deepOrange,)),
            ],
          )
        ],
      ),
    );
  }

  void _onTapEditButton(){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ["New", "Completed", "Cancelled", "Progress"].map((e) {
                return ListTile(
                  onTap: (){},
                  title: Text(e),
                );
              }).toList(),
            ),
            title: Text("Edit Status"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"),
              )
            ],
          );
        });
  }

  void _onTapDeleteButton(){}

  Chip _TaskStatusChip() {
    return Chip(
              backgroundColor: Colors.white,
              label: Text("New", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(116),
                side: BorderSide(color: Colors.deepOrange, width: 2),
              ),
            );
  }
}