import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../core/controllers/tasks_controller/task_model.dart';
import 'task_details_screen.dart';

class TasksBody extends StatelessWidget {
  final bool Function(MapEntry<dynamic, Task>) tasksFilter;
  const TasksBody({super.key, required this.tasksFilter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder(
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index].value;
                      return Card(
                        color: const Color(0xFF282828),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title: Text(
                            task.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: task.completed
                                        ? const Color(0xFFA0A0A0)
                                        : const Color(0xFFFFFCFC),
                                    decoration: task.completed
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: const Color(0xFFA0A0A0)),
                          ),
                          subtitle: !task.completed
                              ? task.description!.isNotEmpty
                                  ? Text(
                                      task.description!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: const Color(0xFFC6C6C6),
                                          ),
                                    )
                                  : null
                              : null,
                          leading: task.completed
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: GestureDetector(
                                    child: SvgPicture.asset(
                                        'assets/svg/check.svg'),
                                    onTap: () {
                                      task.completed = false;
                                      tasksBox.put(tasks[index].key, task);
                                    },
                                  ),
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.check_box_outline_blank_rounded,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                  onPressed: () {
                                    task.completed = true;
                                    tasksBox.put(tasks[index].key, task);
                                  },
                                ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert,
                                color: task.completed
                                    ? const Color(0xFFA0A0A0)
                                    : const Color(0xFFC6C6C6)),
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
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
