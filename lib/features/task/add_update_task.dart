import 'package:atomcto_assignment/features/task/cubits/add_update_task_cubit.dart';
import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key, this.taskId}) : super(key: key);
  final int? taskId;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final AddUpdateTaskCubit _addUpdateTaskCubit = AddUpdateTaskCubit();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskDateController = TextEditingController();
  final _taskFormKey = GlobalKey<FormState>();

  DateTime? taskDateTime;
  String? _taskStatus;

  @override
  void initState() {
    super.initState();
    if(widget.taskId!=null){
      _addUpdateTaskCubit.getTaskDetailsById(widget.taskId);
    }
    _taskStatus=_addUpdateTaskCubit.taskStatusList[0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
        ),
        body: BlocProvider(
          create: (context) => _addUpdateTaskCubit,
          child: BlocConsumer<AddUpdateTaskCubit, AddUpdateTaskState>(
            listener: (context,state){
              if(state is TaskDataLoaded){
                TaskListData taskListData=state.taskListData;
                _titleController.text=taskListData.title!;
                _descriptionController.text=taskListData.description!;
                _taskStatus=taskListData.status;
                taskDateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(taskListData.dueDate!);
                _taskDateController.text=DateFormat('dd/MM/yyyy').format(taskDateTime!).toString();
              }
            },
            builder: (context, state) {
              return buildFormData();
            },
          ),
        ));
  }

  buildFormData() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Form(
        key: _taskFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                readOnly: true,
                controller: _taskDateController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  isDense: true,
                  labelText: 'Date*',
                  hintText: 'Select date',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please select a date.';
                  }
                  return null;
                },
                onTap: () {
                  _selectFromDate();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _titleController,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  isDense: true,
                  labelText: 'Title*',
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  filled: true,
                  fillColor: Colors.white
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter task title.';
                  } else {
                    return null;
                  }
                },
                maxLines: 1,
                maxLength: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  isDense: true,
                  labelText: 'Description of the task*',
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your description.';
                  } else {
                    return null;
                  }
                },
                maxLines: 4,
                maxLength: 200,
              ),
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
                items: _addUpdateTaskCubit.taskStatusList
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
                value: _taskStatus ?? _addUpdateTaskCubit.taskStatusList[0],
                buttonStyleData: const ButtonStyleData(
                  height: 50,
                  padding: EdgeInsets.only(left: 5, right: 5),
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
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_taskFormKey.currentState!.validate()){
                        if(_taskStatus==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Please select task status'),
                          ));
                          return;
                        }
                        createUpdateTask();
                      }

                    },
                    child: Text(widget.taskId != null ? 'Update' : 'Create Task'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createUpdateTask(){
    TaskListData taskListData = TaskListData(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate:  '$taskDateTime',
        status: _taskStatus);

    if(widget.taskId!=null){
      _addUpdateTaskCubit.updateTask(taskListData, context,widget.taskId);
    }else {
      _addUpdateTaskCubit.createTask(taskListData,context);
    }
  }


  //This function is using for select date
  Future<void> _selectFromDate() async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('en', 'GB'),
      context: context,
      initialDate: taskDateTime !=null
          ? taskDateTime!
          : DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      taskDateTime = picked;
      _taskDateController.text =
          DateFormat('dd/MM/yyyy').format(picked).toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addUpdateTaskCubit.close();
  }
}
