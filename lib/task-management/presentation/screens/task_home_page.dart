import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/task-management/data/services/user_task_service.dart';
import 'package:task_manager/task-management/presentation/widgets/textformfield.dart';

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
  Future<void> _onRefresh() async{
    fetchNewTask();
  }

  Map<String,String> json = {
    "title":"",
    "description":"",
    "status":"New"
  };

  updateJson(){
    json.update("title", (value)=>titleController.text.toString());
    json.update("description", (value)=>descriptionController.text.toString());
  }
  
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  clearController(){
    titleController.clear();
    descriptionController.clear();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
              children: [
                Container(
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
                ),
                Container(
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
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context){
                  return Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 8,
                          children: [
                            SizedBox(height: 30,),
                            buildTextFormField(labelText: "Title", hintText: "Enter Title",controller: titleController),
                            buildTextFormField(labelText: "Description", hintText: "Enter Description",controller: descriptionController),
                            TextButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    updateJson();
                                    createNewTaskService(json);
                                    clearController();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text("ADD",style: GoogleFonts.inter(textStyle: TextStyle(color: Colors.indigo),fontSize: 18,fontWeight: FontWeight.w600),)
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          },
        backgroundColor: Colors.indigoAccent,
        child:const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
