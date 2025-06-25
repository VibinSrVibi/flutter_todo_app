import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppContent();
  }
}

class MainAppContent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainAppContent>{
  TextEditingController task=TextEditingController();
  List<String> taskList=[];

   @override
    void initState() {
      super.initState();
      loadTaskList();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("TODO", style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          children: [
            Row(
              children: [
                
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: task,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter you task")
                      ),
                    ),
                  ),
                ),
                MaterialButton(onPressed: (){
                  print(task.text);
                  if(task.text.trim().isEmpty){
                    Fluttertoast.showToast(
                        msg: "Please enter your task",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    setState(() {
                      taskList.add(task.text);
                    });
                    saveTaskList();
                    print(taskList);
                    task.clear();
                  }
                  
                  
                  
                },
                height: 55,
                child: Text("Add", style: TextStyle(color: Colors.white)),
                color: Colors.blue,)
              ],
            ),
            taskList.isEmpty ? Center(child: Text("No data found"),) :
            Flexible(child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context,index){
                final reversedIndex = taskList.length - 1 - index;
                return Row(children: [
                        Expanded(
                          child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(taskList[reversedIndex]),
                                ),
                        ),
                        
                        MaterialButton(onPressed: (){
                          showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Are you sure to delete this task?"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("Cancel")),
                                TextButton(onPressed: (){
                                  print(reversedIndex);
                                  setState(() {
                                    taskList.removeAt(reversedIndex);
                                  });
                                  print(taskList);
                                  saveTaskList();
                                  Navigator.of(context).pop();
                                }, child: Text("Delete",style: TextStyle(color: Colors.red)))
                              ],
                            );
                          });
                          
                        },child: Text("Delete", style: TextStyle(color: Colors.white),),color: Colors.red)
                  ])
                ;
            }))
            
          ],
        ),
      ),
    );
  }

  Future<void> saveTaskList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('taskList', jsonEncode(taskList));
  }

  Future<void> loadTaskList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('taskList');

    if (data != null) {
      setState(() {
        taskList = List<String>.from(jsonDecode(data));
      });
    }
  }
}
