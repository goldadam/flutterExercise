import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/TodosModel.dart';
import 'AddTodoScreen.dart';
import 'widgets/TodoList.dart';

class TabScreen extends StatelessWidget {
  List<Todo> todos;

  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(child: TodoList(this.todos));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // TabBarView(내용), TabBar(버튼)가 동일 controller로 연결되어 있으면..
  // 알아서 탭화면이 전환됨..
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); //animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoScreen()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Complete'),
          ],
        ),
      ),

      //provider 데이터를 활용해 화면을 구성함.. 위젯이 필요하다.. Consumer..
      body: Consumer<TodosModel>(
        // 함수가 자동으로 호출되면서.. 두번째 매갭녀수에 제네릭타입의 provider 데이터 전달..
        builder: (context, model, child) {
          return TabBarView(
            controller: controller,
            children: [
              // 전체 , 완료, 미완료
              TabScreen(model.todos),
              TabScreen(model.todos.where((todo) => !todo.completed).toList()),
              TabScreen(model.todos.where((todo) => todo.completed).toList()),
            ],
          );
        },
      ),
    );
  }
}
