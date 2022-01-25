import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/models/task_model.dart';
import 'package:todolist_app/pages/data_entry_page.dart';
import 'package:todolist_app/providers/task_provider.dart';
import 'package:velocity_x/velocity_x.dart';


class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Todos')
      ),
      body: Consumer<TaskProvider>(
        builder:(context,taskProvider,child)=>Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child:AnimatedSwitcher(
                  child: taskProvider.tasks.isEmpty?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(child: LottieBuilder.asset('assets/swingemoji.json')),
                      'Nothing to do'.text.size(20).make()
                    ],
                  )
                      :
                  ListView.builder(
                      itemCount: taskProvider.tasks.length,
                      itemBuilder: (context,index)=>Dismissible(
                          key: Key(taskProvider.tasks[index].title),
                          onDismissed: (v){
                            taskProvider.removeAt(index);
                          },
                          child: ToDoTile(task: taskProvider.tasks[index],)
                      )
                  ),
                  duration: const Duration(milliseconds: 400),)
            ),
            CupertinoButton(
                color: Colors.teal,
                child: 'Add To-Do'.text.size(20).make(),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DataEntryPage()));
                }
            )
          ],
        ).pOnly(left: 20,right: 20,bottom: 20),
      ),
    );
  }
}

class ToDoTile extends StatefulWidget {
  const ToDoTile({Key? key,required this.task}) : super(key: key);

  final Task task;
  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ListTile(
      title: widget.task.title.text.make(),
      subtitle: widget.task.isCompleted?'Completed'.text.make():'Incomplete'.text.make(),
      onLongPress: (){
        setState(() {
          widget.task.isCompleted=!widget.task.isCompleted;
        });
      },
    ),);
  }
}

