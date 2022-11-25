import 'package:hive/hive.dart';

class TodoDatabase{
  List todos = [];
  late Box todoBox = Hive.box('todos');


  void loadTodos(){
    todos = todoBox.get('TODOLIST');
    print(todos);
  }

  void updateTodos(){
    todoBox.put('TODOLIST', todos);
  }
}