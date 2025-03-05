import 'package:flutter/material.dart';
import 'package:task_manager/task-management/data/services/user_task_service.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  List newTask = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNewTask();
  }
  fetchNewTask() async{
    var Task = await getNewTask();
    setState(() {
      newTask = Task;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        const Text("New Task"),
                        SizedBox(
                          height: screenHeight*0.40,
                          child: ListView.builder(
                              itemCount: newTask.length,
                              itemBuilder: (context,index){
                                final title = newTask[index]["title"];
                                return ListTile(
                                  title: Text("$title"),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        const Text("Complete Task"),
                        SizedBox(
                          height: screenHeight*0.40,
                          child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context,index){
                                return ListTile(
                                  title: Text("task"),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  )
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
        backgroundColor: Colors.indigoAccent,
        child:const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
