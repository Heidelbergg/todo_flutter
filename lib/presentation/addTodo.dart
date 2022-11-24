import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final todoNameController = TextEditingController();
  final dateController = TextEditingController();

  late DateTime selectedDate = DateTime.now();



  String? validateName(String? name){
    if (name == null || name.isEmpty || name == ""){
      return "Indsæt gyldigt navn";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task"),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 20, top: 40, bottom: 30),
            child: TextFormField(
              validator: validateName,
              keyboardType: TextInputType.text,
              controller: todoNameController,
              decoration: InputDecoration(fillColor: Colors.grey.withOpacity(0.25), filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                enabledBorder:
                OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)), labelText: 'Task', labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black,),
                    borderRadius: BorderRadius.circular(15)
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Input task name", hintStyle: TextStyle(color: Colors.grey),),),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, right: 20, bottom: 20),
                child: InkWell(
                  onTap: () async {
                    selectedDate = (await showDatePicker(
                        builder: (context, child) {
                          return Theme(data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF42BEA5), // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: Colors.black,
                              )
                          ),
                              child: child!);
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 90)))
                    )!;
                    setState(() {
                      selectedDate;
                      dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                    });
                  },
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: dateController,
                    enabled: false,
                    decoration: InputDecoration(fillColor: Colors.grey.withOpacity(0.25), filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10)), labelText: 'Date', labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black,),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: DateFormat('dd/MM/yyyy').format(selectedDate), hintStyle: TextStyle(color: Colors.black),),),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();


              }, child: Text("SAVE", style: TextStyle(fontWeight: FontWeight.w700),), style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 60)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              ),)
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 40))
        ],
      )
    );
  }
}