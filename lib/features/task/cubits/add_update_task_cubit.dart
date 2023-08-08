import 'package:atomcto_assignment/components/custom_progressbar.dart';
import 'package:atomcto_assignment/features/home/home_page.dart';
import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:atomcto_assignment/services/db_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'add_update_task_state.dart';

class AddUpdateTaskCubit extends Cubit<AddUpdateTaskState> {
  AddUpdateTaskCubit() : super(AddUpdateTaskInitial());

  List<String> taskStatusList = ['Incomplete','Completed'];

  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<void> getTaskDetailsById(taskId) async {
     final taskListModel = await _databaseProvider.getTaskById(taskId);
      if(taskListModel.taskList!.isNotEmpty){
        emit(TaskDataLoaded(taskListModel.taskList![0]));

      }
  }

  Future<void> updateTask(taskListData, context, taskId) async {
    try {
      CustomProgressBar.showLoader(context);
      await Future.delayed(const Duration(milliseconds: 500));
      await _databaseProvider.updateTask(taskListData, taskId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Task updated successfully!'),
      ));
      CustomProgressBar.cancelLoader(context);
      navigateToHomePage(context);

    } catch (ex) {
      CustomProgressBar.cancelLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $ex'),
      ));
    }
  }

  Future<void> createTask(taskListData, context) async {
    try {
      CustomProgressBar.showLoader(context);

      await _databaseProvider.createTask(taskListData);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Task created successfully!'),
      ));
      CustomProgressBar.cancelLoader(context);
      navigateToHomePage(context);


    } catch (ex) {
      CustomProgressBar.cancelLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $ex'),
      ));
    }
  }


  navigateToHomePage(context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<HomePage>(
      builder: (BuildContext context) {
        return const HomePage();},
    ), (Route<dynamic> route) => false);
  }
}
