import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/controllers/name_controller.dart';
import 'core/controllers/tasks_controller.dart';
import 'Screens/home_screen.dart';
import 'Screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? username = await SharedPreferences.getInstance().then(
    (value) {
      return value.getString('username');
    },
  );
  File jsonFile =
      File('${(await getApplicationDocumentsDirectory()).path}/tasks.json');
  final initialTasks = await jsonFile.exists()
      ? await jsonFile.readAsString().then((contents) {
          final List<dynamic> json = jsonDecode(contents);
          return json.map((task) => Task.fromJson(task)).toList();
        })
      : <Task>[];
  runApp(BlocProvider(
      create: (BuildContext context) => NameController(username ?? ''),
      child: BlocProvider(
          create: (BuildContext context) => TasksController(initialTasks),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xff15B86C),
          secondary: Colors.greenAccent,
          surface: Color(0xff181818),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff15B86C),
            foregroundColor: const Color(0xfffffcfc),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff15B86C),
          foregroundColor: const Color(0xfffffcfc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        useMaterial3: true,
      ),
      home: BlocBuilder<NameController, NameState>(
          builder: (BuildContext context, NameState nameState) =>
              nameState.name.isEmpty ? StartScreen() : const HomeScreen()),
    );
  }
}
