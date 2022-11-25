import 'package:hive/hive.dart';

class TodoDatabase{
  List todos = [];
  final todoBox = Hive.box('todos');


  void loadTodos(){
    todos = todoBox.get('TODOLIST');
  }

  void updateTodos(){
    todoBox.put('TODOLIST', todos);
  }
}