import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:todo/features/home/views/create_todo_page.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Routemaster.of(context).push(CreateTodoPage.routeName),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(
              width: 10,
            ),
            Text('New Task'),
          ],
        ),
      ),
    );
  }
}
