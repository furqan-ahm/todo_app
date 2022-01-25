import 'package:flutter/material.dart';
import 'package:todolist_app/models/task_model.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tasks=[];


  get getTasks=>tasks;


  bool addTask(Task newTask){
    if(tasks.any((element) => newTask.title==element.title))return false;
    tasks.add(newTask);
    notifyListeners();
    return true;
  }

  removeAt(int index){
    tasks.removeAt(index);
    notifyListeners();
  }

}