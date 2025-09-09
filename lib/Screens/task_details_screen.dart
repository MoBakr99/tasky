import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../core/widgets/custom_form_field.dart';
import '../core/controllers/tasks_controller/task_model.dart';
import '../core/controllers/priority_controller/priority_controller.dart';

class TaskDetailsScreen extends StatelessWidget {
  TaskDetailsScreen({super.key, this.taskKey}) {
    if (taskKey != null) {
      final task = Hive.box<Task>('tasks').get(taskKey);
      _taskNameController.text = task!.name;
      _taskDescriptionController.text = task.description ?? '';
    }
  }

  final int? taskKey;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PriorityController(
          Hive.box<Task>('tasks').get(taskKey)?.highPriority ?? false),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            taskKey == null ? 'New Task' : 'Edit Task',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomFormField(
                      fieldTitle: 'Task Name',
                      hintText: 'Finish UI design for login screen',
                      controller: _taskNameController,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      fieldTitle: 'Task Description',
                      hintText:
                          'Finish onboarding UI and hand off to devs by Thursday.',
                      maxLines: 5,
                      controller: _taskDescriptionController,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('High Priority',
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Spacer(),
                        BlocBuilder<PriorityController, PriorityState>(
                          builder: (BuildContext context,
                                  PriorityState priorityState) =>
                              Switch(
                            value: priorityState.highPriority,
                            onChanged: (value) {
                              context
                                  .read<PriorityController>()
                                  .add(ChangePriority(value));
                            },
                            activeColor: const Color(0xfffffcfc),
                            activeTrackColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: BlocBuilder<PriorityController, PriorityState>(
              builder: (BuildContext context, PriorityState priorityState) {
                return FloatingActionButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final task = Task(
                        name: _taskNameController.text.trim(),
                        description: _taskDescriptionController.text.trim(),
                        highPriority: context
                            .read<PriorityController>()
                            .state
                            .highPriority,
                      );
                      if (taskKey == null) {
                        Hive.box<Task>('tasks').add(task);
                      } else {
                        task.completed =
                            Hive.box<Task>('tasks').get(taskKey)!.completed;
                        Hive.box<Task>('tasks').put(taskKey, task);
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: 10),
                      Text(taskKey == null ? 'Add Task' : 'Save Changes'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
