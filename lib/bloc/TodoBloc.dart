// 블락 클래스는 나중에 만들어줘야 함..
import 'package:bloc/bloc.dart';

import './event/TodoEvent.dart';
import './state/TodoState.dart';

// 공통의 조상 역할의 위젯에서 등록할 bloc 클래스
// 제네릭 타입 : 이벤트 - 상태
class TodosBloc extends Bloc<TodoEvent, TodoState> {
  // 생성자 선언 필수
  // 상위 생성자 호출 .. 매개변수 상태 초기값 지정....
  TodosBloc() : super(TodoState([])) {
    // 이벤트 발생시 어떻게 움직일 것인지 생성사 생성시 명시해줘야 함.
    // event : 발생한 event
    // emit : 함수.. 상태 발행 함수...

    // 왜 다 발행시 TodoState 객체를 재생성할까?
    // 상태는 변경되는 것이 아닌, 기존 상태를 참조해서 새로 만들어지는 것 뿐이기 때문에
    // 하기와 같이 계속해서 신규로 생성하는 것임.
    // 왜? -> 내부적으로 변경점을 찾는 것보다 삭제 -> 신규생성하는 것이 훨씬 속도가 더 빠르다(아마 탐색속도로 추정)
    on<AddTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)
        ..add(event.todo); // 기존의 상태값을 얻어서 add..
      // Bloc 클래스 내에서 state.. 자동으로 유지되는 변수.. bloc이 관리하는 상태를 지칭함..
      emit(TodoState(newTodos));
    });
    // 이벤트 삭제..
    on<DeleteTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)..remove(event.todo);
      emit(TodoState(newTodos));
    });

    // 토글 이벤트 수행..
    on<ToggleCompletedEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodoState(newTodos));
    });

    // 트랜지션
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
