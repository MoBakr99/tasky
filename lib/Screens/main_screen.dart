import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/widgets/main_app_bar.dart';

import '../core/controllers/tasks_controller/task_model.dart';
import '../core/controllers/index_controller/index_controller.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Widget _switchAppBar(BuildContext context, int index) {
  //   switch (index) {
  //     case 0:
  //       return const HomeAppBar();
  //     default:
  //       return MainAppBar(
  //         title: ['To Do Tasks', 'Completed Tasks', 'My Profile'][index - 1],
  //         onBackButtonPressed: () {
  //           context.read<IndexController>().add(ChangeIndex(0));
  //         },
  //       );
  //   }
  // }

  Widget _switchBody(int index) {
    switch (index) {
      case 0:
        return const HomeBody();
      case 1:
        return TasksBody(
          tasksFilter: (MapEntry<dynamic, Task> entry) =>
              !entry.value.completed,
        );
      case 2:
        return TasksBody(
          tasksFilter: (MapEntry<dynamic, Task> entry) => entry.value.completed,
        );
      case 3:
        return const ProfileBody();
      default:
        return const HomeBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexController(),
      child: BlocBuilder<IndexController, IndexState>(
        builder: (BuildContext context, IndexState indexState) => Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(72),
              // child: _switchAppBar(context, indexState.index)
              child: indexState.index == 0
                  ? const HomeAppBar()
                  : MainAppBar(
                      title: [
                        'To Do Tasks',
                        'Completed Tasks',
                        'My Profile'
                      ][indexState.index - 1],
                      onBackButtonPressed: () {
                        context.read<IndexController>().add(ChangeIndex(0));
                      },
                    )),
          body: _switchBody(indexState.index),
          floatingActionButton: indexState.index == 0 ? const HomeFAB() : null,
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                context.read<IndexController>().add(ChangeIndex(index));
              },
              currentIndex: indexState.index,
              // selectedItemColor: const Color(0xFF15B86C),
              // unselectedItemColor: const Color(0xFFC6C6C6),
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
                            ? Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor!
                            : Theme.of(context)
                                .bottomNavigationBarTheme
                                .unselectedItemColor!,
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
                              ? Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor!
                              : Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor!,
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
                            ? Theme.of(context)
                                .bottomNavigationBarTheme
                                .selectedItemColor!
                            : Theme.of(context)
                                .bottomNavigationBarTheme
                                .unselectedItemColor!,
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
                              ? Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .selectedItemColor!
                              : Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor!,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    label: 'Profile'),
              ]),
        ),
      ),
    );
  }
}
