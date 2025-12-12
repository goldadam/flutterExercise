import '../state/TodoState.dart';

//bloc 에 발생시키기 위한 이벤트..
//이벤트 발생시키면서.. 데이터를 bloc에 전달해야 해서, 클래스로..생성
// 여러 이벤트를 동일 타입으로 식별하기 위해서 상위 클래스 설계..
/*
결론부터 말씀드리면, 메서드 강제 구현이 아니라 "타입(Type)을 하나로 묶기 위해서(Grouping)" 상속받는 것입니다.
 */
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  Todo todo;

  AddTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  Todo todo;

  DeleteTodoEvent(this.todo);
}

class ToggleCompletedEvent extends TodoEvent {
  Todo todo;

  ToggleCompletedEvent(this.todo);
}
