import 'package:flutter/material.dart';

import '../widgets/task_count_summery_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16,),
          SizedBox(
            height: 101,
            child: ListView.separated(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return TaskCountSammeryCard(title: 'Progress', count: 13,);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 4),

            ),
          ),
        ],
      ),
    );
  }
}
