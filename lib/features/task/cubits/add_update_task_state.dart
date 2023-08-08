part of 'add_update_task_cubit.dart';

@immutable
abstract class AddUpdateTaskState {
  const AddUpdateTaskState();
}

class AddUpdateTaskInitial extends AddUpdateTaskState {}
class UpdateDateState extends AddUpdateTaskState {
  const UpdateDateState(this.selectedDate);
  final String selectedDate;

}
class TaskDataLoaded extends AddUpdateTaskState {
  const TaskDataLoaded(this.taskListData);
  final TaskListData taskListData;
}

