import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_flutter/data/todoDatabase.dart';
import 'package:todo_flutter/presentation/addTodo.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoDatabase tdb = TodoDatabase();

  @override
  void initState() {
    if (tdb.todoBox.get('TODOLIST') == null){
      tdb.todos = [
        ['Eat crayons', '26/11/2022', false],
        ['Eat balls', '27/11/2022', false],
      ];
    } else {
      tdb.loadTodos();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Dew it"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Icon(Icons.date_range),
                  Padding(padding: EdgeInsets.only(left: 5, right: 5)),
                  Text('${DateFormat('E').format(DateTime.now())} ${DateFormat('d').format(DateTime.now())} ${DateFormat('y').format(DateTime.now())}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ),
          const Divider(thickness: 2),
          ListView.builder(
              shrinkWrap: true,
              itemCount: tdb.todos.length,
              itemBuilder: (context, index){
            return CheckboxListTile(
              title: Text(tdb.todos[index][0]),
              subtitle: Text(tdb.todos[index][1]),
              value: tdb.todos[index][2],
              onChanged: (bool? value) {
                setState(() {
                  tdb.todos[index][2] = value!;
                  tdb.updateTodos();
                });
              },
            );
          }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTodoPage())).then((value) {
          setState(() {
            tdb.updateTodos();
          });
        });
      }, icon: Icon(Icons.add), label: Text("ADD TASK", style: TextStyle(fontWeight: FontWeight.w700),)),
    );
  }
}