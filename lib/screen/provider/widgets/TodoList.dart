import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/TodosModel.dart';

class TodoListItem extends StatelessWidget {
  Todo todo;

  TodoListItem(this.todo);

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool? checked) {
          // 상위 provider의 함수만 호출해서.. 상태값을 변경하면 된다..(체크박스가 눌렸을 때..)
          // provider 데이터로 화면을 꾸미지 않는다..
          // listener : false - 변경사항 나한테는 전파시킬 필요가 없기 때문..
          Provider.of<TodosModel>(context, listen: false).toggleTodo(todo);
        },
      ),
      title: Text(todo.title),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          Provider.of<TodosModel>(context, listen: false).deleteTodo(todo);
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  List<Todo> todos;

  TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    return ListView(children: getChildrenTodos());
  }

  List<Widget> getChildrenTodos() {
    return todos.map((todo) => TodoListItem(todo)).toList();
  }
}
