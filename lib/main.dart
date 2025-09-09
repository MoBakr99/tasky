import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'core/controllers/name_controller/name_controller.dart';
import 'core/controllers/tasks_controller/task_model.dart';
import 'themes/themes.dart';
import 'Screens/home_screen.dart';
import 'Screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  final String? username = await SharedPreferences.getInstance().then(
    (value) {
      return value.getString('username');
    },
  );
  runApp(BlocProvider(
      create: (BuildContext context) => NameController(username ?? ''),
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
      home: BlocBuilder<NameController, NameState>(
          builder: (BuildContext context, NameState nameState) =>
              nameState.name.isEmpty ? StartScreen() : const HomeScreen()),
    );
  }
}
