import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/common/controller/completed_task_controller.dart';
import 'package:task_manager/common/controller/new_task_controller.dart';
import 'package:task_manager/common/style.dart';
import 'package:task_manager/task-management/data/services/user_task_service.dart';
import 'package:task_manager/task-management/presentation/widgets/textformfield.dart';
import 'package:get/get.dart';

class TaskHomePage extends StatelessWidget {
  TaskHomePage({super.key});

  var newTaskController = Get.put(NewTaskController());
  var completedTaskController = Get.put(CompletedTaskController());

  Map<String, String> json = {"title": "", "description": "", "status": "New"};

  updateJson() {
    json.update("title", (value) => titleController.text.toString());
    json.update("description", (value) => descriptionController.text.toString());
  }

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  clearController() {
    titleController.clear();
    descriptionController.clear();
  }

  Future<void> _onRefresh() async{
    newTaskController.fetchNewTask();
  }
  Future<void> _onRefreshCompleteTask() async{
    completedTaskController.fetchCompletedTask();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: [
                TabBar(
                    tabs: [
                      Tab(
                        text: "New Task",
                      ),
                      Tab(
                        text: "Completed",
                      )
                    ]
                ),
                Expanded(
                  child: TabBarView(
                      children: [
                        Obx(
                                ()=>RefreshIndicator(
                                  onRefresh: _onRefresh,
                                  child: ListView.builder(
                                  itemCount: newTaskController.newTask.length,
                                  itemBuilder: (context, index) {
                                    final title = newTaskController.newTask[index]["title"];
                                    final _id = newTaskController.newTask[index]["_id"];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: taskBackgroundColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: ListTile(
                                          title: Text("$title"),
                                          leading: IconButton(
                                              onPressed: (){
                                                updateTaskStatus(_id);
                                                newTaskController.newTask.removeAt(index);
                                              },
                                              icon:Icon(Icons.check_box_outline_blank,color: selectionColor,)
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                        ),
                        Obx(
                                ()=>RefreshIndicator(
                              onRefresh: _onRefreshCompleteTask,
                              child: ListView.builder(
                                  itemCount: completedTaskController.completedTask.length,
                                  itemBuilder: (context, index) {
                                    final title = completedTaskController.completedTask[index]["title"];
                                    final _id = completedTaskController.completedTask[index]["_id"];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: taskBackgroundColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: ListTile(
                                          title: Text("$title"),
                                          leading: IconButton(
                                              onPressed: (){

                                              },
                                              icon:Icon(Icons.check_box,color: Colors.green,)
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                        )
                      ]
                  ),
                )
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 8,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            buildTextFormField(
                                labelText: "Title",
                                hintText: "Enter Title",
                                controller: titleController),
                            buildTextFormField(
                                labelText: "Description",
                                hintText: "Enter Description",
                                controller: descriptionController),
                            TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    updateJson();
                                    createNewTaskService(json);
                                    clearController();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "ADD",
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(color: Colors.indigo),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          backgroundColor: Colors.indigoAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
