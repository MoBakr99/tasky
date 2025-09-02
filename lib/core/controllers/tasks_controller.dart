import 'dart:io';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class Task {
  final String name;
  final String? description;
  final bool highPriority;
  bool completed;

  Task({
    required this.name,
    this.description,
    this.highPriority = false,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
      highPriority: json['highPriority'],
      completed: json['completed'],
    );
  }
}

class TasksState {
  final List<Task> tasks;

  TasksState([List<Task>? tasks]) : tasks = tasks ?? <Task>[];
}

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);
}

class RemoveTask extends TaskEvent {
  final Task task;

  RemoveTask(this.task);
}

class ClearTasks extends TaskEvent {}

class ToggleTaskCompletion extends TaskEvent {
  final Task task;

  ToggleTaskCompletion(this.task);
}

class TasksController extends Bloc<TaskEvent, TasksState> {
  TasksController(List<Task>? initialTasks) : super(TasksState(initialTasks)) {
    on<AddTask>((event, emit) {
      state.tasks.add(event.task);
      emit(TasksState(state.tasks));
      // print('Tasks: ${state.tasks}');
      saveChanges();
    });

    on<RemoveTask>((event, emit) {
      state.tasks.remove(event.task);
      emit(TasksState(state.tasks));
      saveChanges();
    });

    on<ClearTasks>((event, emit) {
      state.tasks.clear();
      emit(TasksState(state.tasks));
      saveChanges();
    });

    on<ToggleTaskCompletion>((event, emit) {
      final index = state.tasks.indexOf(event.task);
      if (index != -1) {
        state.tasks[index].completed = !state.tasks[index].completed;
        state.tasks.sort((a, b) {
          if (a.completed == b.completed) {
            return 0;
          }
          return a.completed ? -1 : 1;
        });
        emit(TasksState(state.tasks));
        saveChanges();
      }
    });
  }

  void saveChanges() async {
    List<Map<String, dynamic>> jsonTasks = state.tasks.map((task) {
      return {
        'name': task.name,
        'description': task.description,
        'highPriority': task.highPriority,
        'completed': task.completed,
      };
    }).toList();

    var encoded = jsonEncode(jsonTasks);
    File jsonFile =
        File('${(await getApplicationDocumentsDirectory()).path}/tasks.json');
    await jsonFile.writeAsString(encoded);
  }
}
