import 'package:flutter/material.dart';
class taskSummaryCard extends StatelessWidget {
  const taskSummaryCard({
    super.key, required this.title, required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width/5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(count.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
              FittedBox(child: Text(title,style: TextStyle(color: Colors.grey),))

            ],
          ),
        ),
      ),

    );
  }
}