import 'package:atomcto_assignment/components/app_widgets.dart';
import 'package:atomcto_assignment/models/task_list_data.dart';
import 'package:atomcto_assignment/utils/color_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class TaskListTile extends StatelessWidget {
  const TaskListTile({
    Key? key,
    required this.onDelete,
    required this.onEditClick,
    required this.taskListData,
  }) : super(key: key);

  final Function() onEditClick;
  final Function() onDelete;
  final TaskListData taskListData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTextBadge(
                  '${taskListData.status}',
                  taskListData.status == 'Incomplete'
                      ? ColorStyle.incompleteColor
                      : ColorStyle.completedColor),
              const SizedBox(
                height: 5,
              ),
              Text(
                taskListData.title!,
                style: TxtStyle.headingStyle,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                taskListData.description!,
                style: TxtStyle.subHeadingStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                  'Due Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(taskListData.dueDate!))}',style: TxtStyle.subHeadingStyle,),
            ],
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: const Icon(Icons.edit_calendar),
                    onPressed: () => onEditClick()),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    showAlertDialog(
                        context: context,
                        onTapOk: () {onDelete();},
                        title: 'Alert!!',
                        message: 'Do you really want to delete this task?',
                        btn2Text: 'Yes',
                        btn1Text: 'No');

                  },
                ),
              ],
            ),
          )),
    );
  }
}
