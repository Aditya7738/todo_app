import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';

class ToDoNotifier extends Notifier<List<ToDo>> {
  @override
  List<ToDo> build() {
    return <ToDo>[];
  }

  // void addToDo(ToDo item) {
  //   state.add(item);
  // }

  void addToDo(String title) {
    ToDo todo = ToDo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
    );

    state = [...state, todo];
  }

  void toggleToDo(String id) {
    // state[index].isCompleted = isComplete;
    state = [
      for (var todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !(todo.isCompleted))
        else
          todo,
    ];
  }

  void updateToDo(String id, String newTitle) {
    state = [
      for (var todo in state)
        if (todo.id == id) todo.copyWith(title: newTitle) else todo,
    ];
  }

  void deleteToDo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void removeAllCompleted() {
    state = state.where((todo) => todo.isCompleted != true).toList();
  }
}

final todoProvider = NotifierProvider<ToDoNotifier, List<ToDo>>(ToDoNotifier.new);
