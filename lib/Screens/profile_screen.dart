import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Screens/start_screen.dart';
import 'package:tasky/Screens/user_details_screen.dart';
import 'package:tasky/core/controllers/theme_controller/theme_controller.dart';

import '../core/controllers/tasks_controller/task_model.dart';
import '../core/controllers/user_controller/user_controller.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeController, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<UserController, UserState>(
              builder: (BuildContext context, UserState userState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                      SvgPicture.asset(
                        'assets/svg/avatar.svg',
                        width: 85,
                        height: 85,
                        colorFilter: ColorFilter.mode(
                            themeState.isDark
                                ? const Color(0xFFFFFCFC)
                                : const Color(0xff161F1B),
                            BlendMode.srcIn),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                            color: themeState.isDark
                                ? const Color(0xFF282828)
                                : const Color(0xffffffff),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50))),
                        child: SvgPicture.asset(
                          'assets/svg/camera.svg',
                          width: 15,
                          height: 15,
                          colorFilter: themeState.isDark
                              ? const ColorFilter.mode(
                                  Color(0xFFFFFCFC), BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  Color(0xff161F1B), BlendMode.srcIn),
                          fit: BoxFit.none,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userState.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      userState.quote,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile Info',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svg/user_icon.svg',
                        width: 18,
                        height: 18,
                        colorFilter: themeState.isDark
                            ? const ColorFilter.mode(
                                Color(0xFFFFFCFC), BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Color(0xff161f1b), BlendMode.srcIn),
                      ),
                      title: Text(
                        'User Details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: SvgPicture.asset(
                        'assets/svg/arrow_right.svg',
                        width: 14,
                        height: 14,
                        colorFilter: !themeState.isDark
                            ? const ColorFilter.mode(
                                Color(0xff3a4640), BlendMode.srcIn)
                            : null,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                      child: Divider(
                        color: Color(0xFF6E6E6E),
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svg/moon.svg',
                        width: 18,
                        height: 18,
                        colorFilter: !themeState.isDark
                            ? const ColorFilter.mode(
                                Color(0xff161F1B), BlendMode.srcIn)
                            : null,
                      ),
                      title: Text(
                        'Dark Mode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Switch(
                        value: themeState.isDark,
                        activeColor: const Color(0xfffffcfc),
                        activeTrackColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          context
                              .read<ThemeController>()
                              .add(value ? DarkTheme() : LightTheme());
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setBool('isDark', value);
                          });
                        },
                      ),
                      onTap: () {
                        context.read<ThemeController>().add(
                            themeState.isDark ? LightTheme() : DarkTheme());
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setBool('isDark', !themeState.isDark);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                      child: Divider(
                        color: Color(0xFF6E6E6E),
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svg/exit.svg',
                        width: 18,
                        height: 18,
                        colorFilter: !themeState.isDark
                            ? const ColorFilter.mode(
                                Color(0xff161F1B), BlendMode.srcIn)
                            : null,
                      ),
                      title: Text(
                        'Log Out',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: SvgPicture.asset(
                        'assets/svg/arrow_right.svg',
                        width: 14,
                        height: 14,
                        colorFilter: !themeState.isDark
                            ? const ColorFilter.mode(
                                Color(0xff3a4640), BlendMode.srcIn)
                            : null,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Log Out'),
                                  content: const Text(
                                      'Are You Sure You Want to Erase All Your Data?'),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          context
                                              .read<UserController>()
                                              .add(ChangeName(''));
                                          context
                                              .read<UserController>()
                                              .add(ChangeQuote(''));
                                          Hive.box<Task>('tasks').clear();
                                          SharedPreferences.getInstance().then(
                                            (prefs) {
                                              prefs.clear();
                                              prefs.setBool(
                                                  'isDark', themeState.isDark);
                                            },
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StartScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text('Yes')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'))
                                  ],
                                ));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
