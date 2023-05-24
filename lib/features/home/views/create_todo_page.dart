import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/providers/firebase_providers.dart';
import 'package:todo/features/home/controller/todo_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class CreateTodoPage extends ConsumerWidget {
  static const String routeName = '/create-todo-page';
  const CreateTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    TextEditingController todoDescriptionController = TextEditingController();

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Create a todo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),

              //Todo

              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 3,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Todo',
                  ),
                  controller: todoController,
                ),
              ),

              //Todo Desc

              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 3,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Todo Description',
                  ),
                  controller: todoDescriptionController,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              FilledButton.tonal(
                  onPressed: () {
                    final String todoId = const Uuid().v1();

                    TodoModel todoModel = TodoModel(
                      todo: todoController.text.trim(),
                      time: DateTime.now(),
                      isComplete: false,
                      todoId: todoId,
                      todoDesc: todoDescriptionController.text.trim(),
                    );

                    ref.watch(todoControllerProvider).createTodo(
                          todo: todoModel,
                          uid: ref.watch(firebaseAuthProvider).currentUser!.uid,
                        );

                    Navigator.pop(context);
                  },
                  child: const Text('Create')),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
