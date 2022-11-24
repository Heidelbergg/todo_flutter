import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/presentation/addTodo.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final now = DateTime.now();
  late List todoItems = [];

  _fetchTodos() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

  }

  @override
  void initState() {
    _fetchTodos();
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
              itemCount: ,
              itemBuilder: (context, index){
            return CheckboxListTile(value: null, onChanged: (bool? value) {},);
          }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTodoPage())).then((v) {
          _fetchTodos();
        });
      }, icon: Icon(Icons.add), label: Text("ADD TASK", style: TextStyle(fontWeight: FontWeight.w700),)),
    );
  }
}