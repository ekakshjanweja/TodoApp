class TodoModel {
  final String todo;
  final DateTime time;
  final bool isComplete;
  final String todoId;
  final String todoDesc;

  TodoModel({
    required this.todo,
    required this.time,
    required this.isComplete,
    required this.todoId,
    required this.todoDesc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todo': todo,
      'time': time.millisecondsSinceEpoch,
      'isComplete': isComplete,
      'todoId': todoId,
      'todoDesc': todoDesc,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      todo: map['todo'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      isComplete: map['isComplete'] as bool,
      todoId: map['todoId'] as String,
      todoDesc: map['todoDesc'] as String,
    );
  }
}
