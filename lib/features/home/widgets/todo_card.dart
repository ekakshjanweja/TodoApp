import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/common/providers/firebase_providers.dart';
import 'package:todo/features/home/controller/todo_controller.dart';
import 'package:todo/models/todo_model.dart';

class TodoCard extends ConsumerStatefulWidget {
  final TodoModel todo;
  const TodoCard({
    super.key,
    required this.todo,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.Hm().format(widget.todo.time);
    return GestureDetector(
      onTap: () {
        showTodoDetails(
          context: context,
          ref: ref,
          todoModel: widget.todo,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 24,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.todo,
                    style: TextStyle(
                      fontSize: 20,
                      decoration: widget.todo.isComplete
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Created on $formattedDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                ref.watch(todoControllerProvider).updateTodoStatus(
                      uid: ref.watch(firebaseAuthProvider).currentUser!.uid,
                      todoId: widget.todo.todoId,
                      isComplete: !widget.todo.isComplete,
                    );
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.todo.isComplete
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                        : Colors.white.withOpacity(0.2)),
                child: Icon(widget.todo.isComplete ? Icons.check : null),
              ),
            )
          ],
        ),
      ),
    );
  }
}

showTodoDetails({
  required BuildContext context,
  required final TodoModel todoModel,
  required WidgetRef ref,
}) {
  return showModalBottomSheet(
    showDragHandle: true,
    isDismissible: true,
    context: context,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todoModel.todo,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  ref.watch(todoControllerProvider).deleteTodo(
                        todoId: todoModel.todoId,
                        uid: ref.watch(firebaseAuthProvider).currentUser!.uid,
                      );

                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            todoModel.todoDesc,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    ),
  );
}
