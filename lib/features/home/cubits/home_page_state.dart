part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {
  const HomePageState();
}

class HomePageInitial extends HomePageState {}

class HomePageDataLoading extends HomePageState {}


class HomePageDataLoaded extends HomePageState {
  const HomePageDataLoaded(this.taskList);
  final List<TaskListData> taskList;
}

class HomePageDataError extends HomePageState {
  const HomePageDataError(this.message);
  final String? message;
}
