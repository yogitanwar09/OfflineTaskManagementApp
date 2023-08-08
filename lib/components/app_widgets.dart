
import 'package:atomcto_assignment/utils/color_style.dart';
import 'package:flutter/material.dart';

Widget showTextBadge(String badgeText, [Color? backgroundColor, Color? textColor]){
  return ClipRRect(
    borderRadius: BorderRadius.circular(4.0),
    child: Container(
      padding: const EdgeInsets.fromLTRB(8,2,8,2),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: backgroundColor ?? Colors.black87,width: 1)
      ),
      child: Text(badgeText,style: TxtStyle.badgeStyle.copyWith(color: Colors.white),),
    ),
  );

}

showAlertDialog({
  required BuildContext context,title,message,btn1Text,btn2Text, required VoidCallback onTapOk}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: Text(
            '$message'),
        actions: [
          ElevatedButton(
            child: Text('$btn1Text'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 10,),
          ElevatedButton(
            child: Text('$btn2Text'),
            onPressed: () {
              onTapOk();
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}