import 'package:atomcto_assignment/components/error_page.dart';
import 'package:atomcto_assignment/components/list_skeleton.dart';
import 'package:atomcto_assignment/components/no_record_page.dart';
import 'package:atomcto_assignment/components/task_list_tile.dart';
import 'package:atomcto_assignment/features/home/cubits/home_page_cubit.dart';
import 'package:atomcto_assignment/features/task/add_update_task.dart';
import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:atomcto_assignment/utils/color_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskListData> _taskList = [];
  String? _taskStatus;
  final HomePageCubit _homePageCubit = HomePageCubit();

  @override
  void initState() {
    super.initState();
    _homePageCubit.fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATOM CTO'),
        actions: [

          IconButton(
            onPressed: () async {
              showFilterDialog();
            },
            icon:  const Icon(Icons.filter_alt_outlined),
          )

        ],
      ),
      body: BlocProvider(
        create: (context) => _homePageCubit,
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomePageDataLoading || state is HomePageInitial) {
              return const Padding(
                padding: EdgeInsets.all(15.0),
                child: ListSkeleton(),
              );
            } else if (state is HomePageDataLoaded) {
              _taskList.clear();
              _taskList.addAll(state.taskList);
            } else if (state is HomePageDataError) {
              return const ErrorPage();
            }

            return showTaskListData();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToTaskPage();
        },
      ),
    );
  }

  navigateToTaskPage({taskId}) {
    Navigator.of(context).push(MaterialPageRoute<TaskPage>(
      builder: (BuildContext context) {
        return TaskPage(taskId: taskId);
      },
    ));
  }

  showTaskListData() {
    return _taskList.isEmpty
        ? const NoRecordFoundPage(
            icon: Icons.task_outlined, message: 'No task found')
        : ListView.builder(
            itemCount: _taskList.length,
            itemBuilder: (context, index) => TaskListTile(
                onDelete: () {
                  _homePageCubit.deleteTask(_taskList[index].taskId!, context);
                },
                onEditClick: () {
                  navigateToTaskPage(taskId: _taskList[index].taskId);
                },
                taskListData: _taskList[index]));
  }

  showFilterDialog() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom+20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Task Status',
                      style: TxtStyle.subHeadingStyle.copyWith(color: Colors.black,fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),

                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true,
                    items: _homePageCubit.taskStatusList
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),

                    onChanged: (value) {
                      _taskStatus = value.toString();
                    },
                    onSaved: (value) {
                    },
                    value: _taskStatus ?? _homePageCubit.taskStatusList[0],
                    buttonStyleData: const ButtonStyleData(
                      height: 50,
                      padding: EdgeInsets.only(left: 15, right: 15),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          _homePageCubit.fetchTaskList();
                          if (!mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Clear Filter'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if(_taskStatus!=null){
                            _homePageCubit.fetchTaskList(filterStatus: _taskStatus);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please select task status!'),
                            ));
                          }

                          if (!mounted) return;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Apply Filter'),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
