import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../core/controllers/name_controller/name_controller.dart';
import '../core/controllers/tasks_controller/task_model.dart';
import '../core/controllers/index_controller/index_controller.dart';
import 'task_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexController(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<NameController, NameState>(
              builder: (BuildContext context, NameState nameState) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Evening ,${nameState.name}',
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        'One Task at a Time.One Step Closer.',
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: const Color(0xFFC6C6C6)),
                      )
                    ],
                  )),
          toolbarHeight: 72,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset('assets/svg/avatar.svg',
                width: 42, height: 42),
          ),
          leadingWidth: 58, // 42 + 16
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.wb_sunny_outlined),
                onPressed: () {},
                color: const Color(0xFFFFFCFC),
                tooltip: 'Settings',
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF282828))),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('My Tasks',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: Hive.box<Task>('tasks').listenable(),
                builder:
                    (BuildContext context, Box<Task> tasksBox, Widget? child) {
                  final List<MapEntry<dynamic, Task>> tasks =
                      tasksBox.toMap().entries.toList();
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
                                            decorationColor:
                                                const Color(0xFFA0A0A0)),
                                  ),
                                  subtitle: !task.completed
                                      ? task.description!.isNotEmpty
                                          ? Text(
                                              task.description!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color:
                                                        const Color(0xFFC6C6C6),
                                                  ),
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
                                          icon: const Icon(
                                            Icons
                                                .check_box_outline_blank_rounded,
                                            color: Color(0xFF6E6E6E),
                                          ),
                                          onPressed: () {
                                            task.completed = true;
                                            tasksBox.put(
                                                tasks[index].key, task);
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
                                    // onPressed: () {},
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TaskDetailsScreen(
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
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 40,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Add New Task',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<IndexController, IndexState>(
            builder: (BuildContext context, IndexState indexState) =>
                BottomNavigationBar(
                    onTap: (index) {
                      context.read<IndexController>().add(ChangeIndex(index));
                    },
                    currentIndex: indexState.index,
                    selectedItemColor: const Color(0xFF15B86C),
                    unselectedItemColor: const Color(0xFFC6C6C6),
                    selectedFontSize: 12,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: true,
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SvgPicture.asset(
                            'assets/svg/home_icon.svg',
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                              indexState.index == 0
                                  ? const Color(0xFF15B86C)
                                  : const Color(0xFFC6C6C6),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SvgPicture.asset(
                              'assets/svg/task_icon.svg',
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                indexState.index == 1
                                    ? const Color(0xFF15B86C)
                                    : const Color(0xFFC6C6C6),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'To Do'),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SvgPicture.asset(
                            'assets/svg/completed_task_icon.svg',
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                              indexState.index == 2
                                  ? const Color(0xFF15B86C)
                                  : const Color(0xFFC6C6C6),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        label: 'Completed',
                      ),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SvgPicture.asset(
                              'assets/svg/user_icon.svg',
                              width: 18,
                              height: 18,
                              colorFilter: ColorFilter.mode(
                                indexState.index == 3
                                    ? const Color(0xFF15B86C)
                                    : const Color(0xFFC6C6C6),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          label: 'Profile'),
                    ])),
      ),
    );
  }
}
