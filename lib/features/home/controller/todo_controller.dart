import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/repository/todo_repository.dart';
import 'package:todo/models/todo_model.dart';

final todoControllerProvider = StateProvider<TodoController>(
  (ref) => TodoController(
    todoRepository: ref.watch(todoRepositoryProvider),
  ),
);

final getTodosProvider = StreamProvider.family((ref, String uid) {
  final todoController = ref.watch(todoControllerProvider);
  return todoController.getTodos(uid: uid);
});

class TodoController {
  final TodoRepository _todoRepository;

  TodoController({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  void createTodo({required TodoModel todo, required String uid}) {
    _todoRepository.createTodo(todo: todo, uid: uid);
  }

  Stream<List<TodoModel>> getTodos({required String uid}) {
    return _todoRepository.getTodos(uid: uid);
  }

  void updateTodoStatus(
      {required String uid, required String todoId, required bool isComplete}) {
    _todoRepository.updateTodoStatus(
        isComplete: isComplete, todoId: todoId, uid: uid);
  }

  void deleteTodo({
    required String todoId,
    required String uid,
  }) {
    _todoRepository.deleteTodo(todoId: todoId, uid: uid);
  }
}
