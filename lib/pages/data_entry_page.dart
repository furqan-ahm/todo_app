import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/models/task_model.dart';
import 'package:todolist_app/providers/task_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class DataEntryPage extends StatelessWidget {
  DataEntryPage({Key? key}) : super(key: key);

  final TextEditingController _controller=TextEditingController();

  void addTask(BuildContext context){
    Task newTask=Task(title: _controller.text,isCompleted: false);
    if(!Provider.of<TaskProvider>(context,listen: false).addTask(newTask)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task already exists')));
      return;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add To-Do'),
      ),
      body: Column(
        children: [
          'Adding a new task?'.text.size(20).black.semiBold.makeCentered(),
          24.heightBox,
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
            ),
          ),
          60.heightBox,
          CupertinoButton(
              color: Colors.teal,
              child: 'Add To-Do'.text.size(20).make(),
              onPressed: (){
                if(_controller.text.isNotEmpty)addTask(context);
                else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task can not be blank')));
              }
          )
        ],
      ).p(24),
    );
  }
}
