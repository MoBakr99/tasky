import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'core/controllers/user_controller/user_controller.dart';
import 'core/controllers/tasks_controller/task_model.dart';
import 'themes/themes.dart';
import 'Screens/main_screen.dart';
import 'Screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  final prefs = await SharedPreferences.getInstance();
  final String? username = prefs.getString('username');
  final String? quote = prefs.getString('quote');
  runApp(BlocProvider(
      create: (BuildContext context) => UserController(username ?? '', quote ?? ''),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.dark(context),
      home: BlocBuilder<UserController, UserState>(
          builder: (BuildContext context, UserState userState) =>
              userState.name.isEmpty ? StartScreen() : const MainScreen()),
    );
  }
}
