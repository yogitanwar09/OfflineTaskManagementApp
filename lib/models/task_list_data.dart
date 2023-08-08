
class TaskListData {
  TaskListData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    taskId = json['id'];
    description = json['description'];
    dueDate = json['dueDate'];
    status = json['status'];


  }

  TaskListData(
      {this.title,
        this.taskId,
        this.description,
        this.dueDate,
        this.status,
      });

  TaskListData.withError(String errorMessage) {
    error = errorMessage;
  }

  int? taskId;
  String? title;
  String? description;
  String? dueDate;
  String? status;
  String? error;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['status'] = status;
    return data;
  }
}
