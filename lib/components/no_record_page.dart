import 'package:flutter/material.dart';

@immutable
class NoRecordFoundPage extends StatelessWidget {
  const NoRecordFoundPage({
    Key? key,
    required this.icon,
    required this.message,
  }) : super(key: key);

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
  }
}