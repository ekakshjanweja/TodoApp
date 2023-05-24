import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/common/providers/firebase_providers.dart';
import 'package:todo/features/auth/controller/auth_controller.dart';
import 'package:todo/features/home/controller/todo_controller.dart';
import 'package:todo/features/home/widgets/new_task_button.dart';
import 'package:todo/features/home/widgets/todo_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String formattedDate = DateFormat.MMMMEEEEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 48,
              ),

              //Top Row

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Date

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Tasks',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),

                  //Create New Task Button
                  const NewTaskButton(),
                ],
              ),

              const SizedBox(
                height: 48,
              ),

              Expanded(
                child: ref
                    .watch(getTodosProvider(
                        ref.watch(firebaseAuthProvider).currentUser!.uid))
                    .when(
                      data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final todo = data[index];
                          return TodoCard(
                            todo: todo,
                          );
                        },
                      ),
                      error: (error, stackTrace) => Scaffold(
                        body: Center(
                          child: Text(error.toString()),
                        ),
                      ),
                      loading: () => const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        onPressed: () {
          ref.watch(authControllerProvider.notifier).logOut();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
