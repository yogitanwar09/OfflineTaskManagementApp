
import 'package:atomcto_assignment/components/custom_progressbar.dart';
import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:atomcto_assignment/models/task_list_model.dart';
import 'package:atomcto_assignment/services/db_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  final DatabaseProvider _databaseProvider = DatabaseProvider();
  List<String> taskStatusList = ['Incomplete','Completed'];

  Future<void> fetchTaskList({String? filterStatus}) async {
    try {
      emit(HomePageDataLoading());
      TaskListModel taskListModel=TaskListModel();

      if(filterStatus!=null){
        taskListModel= await _databaseProvider.getTaskListByStatus(filterStatus);
      }else{
        taskListModel= await _databaseProvider.getTaskList();
      }


      if (taskListModel.error != null) {
        emit(HomePageDataError(taskListModel.error));
      }else{
        emit(HomePageDataLoaded(taskListModel.taskList!));
      }
    } catch (error) {
      emit(HomePageDataError('$error'));
    }
  }


  Future<void> deleteTask(int id,context) async {
    CustomProgressBar.showLoader(context);
    await _databaseProvider.deleteTask(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Task deleted successfully!'),
    ));
    CustomProgressBar.cancelLoader(context);
    fetchTaskList();
  }
}
