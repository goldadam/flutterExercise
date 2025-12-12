class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}
//bloc에 의해 관리 발행되는 상태

class TodoState {
  List<Todo> todos;

  TodoState(this.todos);
}
