import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/providers/firebase_providers.dart';
import 'package:todo/models/todo_model.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepository(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class TodoRepository {
  final FirebaseFirestore _firebaseFirestore;
  TodoRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _users => _firebaseFirestore.collection('users');

  void createTodo({required TodoModel todo, required String uid}) async {
    await _users
        .doc(uid)
        .collection('todos')
        .doc(todo.todoId)
        .set(todo.toMap());
  }

  Stream<List<TodoModel>> getTodos({required String uid}) {
    return _users
        .doc(uid)
        .collection('todos')
        .orderBy('time', descending: true)
        .snapshots()
        .asyncMap((event) async {
      List<TodoModel> todos = [];

      for (var element in event.docs) {
        var todo = TodoModel.fromMap(element.data());
        todos.add(todo);
      }

      return todos;
    });
  }

  void updateTodoStatus({
    required bool isComplete,
    required String todoId,
    required String uid,
  }) {
    _users
        .doc(uid)
        .collection('todos')
        .doc(todoId)
        .update({'isComplete': isComplete});
  }

  void deleteTodo({
    required String todoId,
    required String uid,
  }) async {
    await _users.doc(uid).collection('todos').doc(todoId).delete();
  }
}
