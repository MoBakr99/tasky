import 'package:hive_ce_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final bool highPriority;

  @HiveField(3)
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

  @override
  String toString() =>
      'Task{Name: $name, Description: $description, HighPriority: $highPriority, Completed: $completed}';
}
