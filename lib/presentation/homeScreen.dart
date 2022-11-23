import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_flutter/presentation/addTodo.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now();

  _setDate( ){

  }

  _fetchTodos(){

  }

  @override
  void initState() {
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
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(onPressed: () {
                  showDatePicker(context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime.now().add(const Duration(days: 120)));
                }, icon: const Icon(Icons.date_range),
                label: Text('${DateFormat('E').format(DateTime.now())} ${DateFormat('d').format(DateTime.now())} ${DateFormat('y').format(DateTime.now())}')),
          ),
          const Divider(thickness: 2,),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTodoPage()));
      }, icon: Icon(Icons.add), label: Text("ADD TASK", style: TextStyle(fontWeight: FontWeight.w700),)),
    );
  }
}