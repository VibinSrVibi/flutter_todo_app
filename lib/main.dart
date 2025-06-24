import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  List<String> taskList=["hai","hello"];
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
                        msg: "This is Center Short Toast",
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
                return Row(children: [
                        Expanded(
                          child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(taskList[index]),
                                ),
                        ),
                        
                        MaterialButton(onPressed: (){
                          print(index);
                          setState(() {
                            taskList.removeAt(index);
                          });
                          print(taskList);
                        },child: Text("Delete", style: TextStyle(color: Colors.white),),color: Colors.red)
                  ])
                ;
            }))
            
          ],
        ),
      ),
    );
  }
}
