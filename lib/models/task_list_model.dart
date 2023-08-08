import 'package:atomcto_assignment/models/task_list_data.dart';

class TaskListModel {
  TaskListModel.fromJson(var json) {
    taskList = [];
    json.forEach(
          (element) => {
        taskList!.add(TaskListData.fromJson(element)),
      },
    );
  }

  TaskListModel.withError(String errorMessage) {
    error = errorMessage;
  }
  TaskListModel({this.taskList});

  List<TaskListData>? taskList;
  String? error;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskList != null) {
      data['data'] = taskList!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}




