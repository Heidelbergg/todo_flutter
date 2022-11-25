import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_flutter/data/todoDatabase.dart';
import 'package:todo_flutter/presentation/addTodo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


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
        title: Text("TooDoo"),
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
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: tdb.todos.length,
              itemBuilder: (context, index){
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context){
                      setState(() {
                        tdb.todos.removeAt(index);
                        tdb.updateTodos();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green, content: Text("Task Removed")));
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: CheckboxListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Optionally
                  side:  BorderSide(color: Colors.black.withOpacity(0.25))
                ),
                tileColor: tdb.todos[index][2] == true ? Colors.grey : null,
                title: tdb.todos[index][2] == false ? Text(tdb.todos[index][0], style: TextStyle(fontWeight: FontWeight.w600),) :  Text(tdb.todos[index][0], style: const TextStyle(decoration: TextDecoration.lineThrough),),
                subtitle: Text(tdb.todos[index][1]),
                value: tdb.todos[index][2],
                onChanged: (bool? value) {
                  setState(() {
                    tdb.todos[index][2] = value!;
                    tdb.updateTodos();
                  });
                },
              ),
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
      }, icon: Icon(Icons.add_box_sharp), label: Text("ADD TASK", style: TextStyle(fontWeight: FontWeight.w700),)),
    );
  }
}