import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasky/core/controllers/theme_controller/theme_controller.dart';

import '../core/controllers/tasks_controller/task_model.dart';
import 'task_details_screen.dart';

class TasksBody extends StatelessWidget {
  final bool Function(MapEntry<dynamic, Task>) tasksFilter;
  const TasksBody({super.key, required this.tasksFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasks').listenable(),
            builder: (BuildContext context, Box<Task> tasksBox, Widget? child) {
              final List<MapEntry<dynamic, Task>> tasks =
                  tasksBox.toMap().entries.where(tasksFilter).toList();
              tasks.sort(
                (a, b) {
                  if (a.value.completed == b.value.completed) {
                    return 0;
                  }
                  return a.value.completed ? -1 : 1;
                },
              );
              return Expanded(
                child: tasks.isEmpty
                    ? Center(
                        child: Text(
                          'Add a New Task!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index].value;
                          return Card(
                            child: BlocBuilder<ThemeController, ThemeState>(
                              builder: (context, themeState) {
                                return ListTile(
                                  title: Text(
                                    task.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: themeState.isDark
                                                ? task.completed
                                                    ? const Color(0xFFA0A0A0)
                                                    : const Color(0xFFFFFCFC)
                                                : task.completed
                                                    ? const Color(0xFF6A6A6A)
                                                    : const Color(0xFF161F1B),
                                            decoration: task.completed
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationColor:
                                                const Color(0xFFA0A0A0)),
                                  ),
                                  subtitle: !task.completed
                                      ? task.description!.isNotEmpty
                                          ? Text(
                                              task.description!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            )
                                          : null
                                      : null,
                                  leading: task.completed
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7, right: 7),
                                          child: GestureDetector(
                                            child: SvgPicture.asset(
                                                'assets/svg/check.svg'),
                                            onTap: () {
                                              task.completed = false;
                                              tasksBox.put(
                                                  tasks[index].key, task);
                                            },
                                          ),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons
                                                .check_box_outline_blank_rounded,
                                            color: themeState.isDark
                                                ? const Color(0xFF6E6E6E)
                                                : const Color(0xffD1DAD6),
                                          ),
                                          onPressed: () {
                                            task.completed = true;
                                            tasksBox.put(
                                                tasks[index].key, task);
                                          },
                                        ),
                                  trailing: PopupMenuButton(
                                    icon: Icon(Icons.more_vert,
                                        color: themeState.isDark
                                            ? task.completed
                                                ? const Color(0xFFA0A0A0)
                                                : const Color(0xFFC6C6C6)
                                            : task.completed
                                                ? const Color(0xff3A4640)
                                                : const Color(0xff3A4640)),
                                    tooltip: 'More',
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry>[
                                      PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                            const SizedBox(width: 8),
                                            Text('Delete',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .error)),
                                          ],
                                        ),
                                        onTap: () {
                                          tasksBox.delete(tasks[index].key);
                                        },
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskDetailsScreen(
                                            taskKey: tasks[index].key),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
