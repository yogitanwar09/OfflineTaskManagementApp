import 'package:atomcto_assignment/features/home/home_page.dart';
import 'package:atomcto_assignment/utils/color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ATOMCTO Project',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        home: const HomePage());
  }
}
