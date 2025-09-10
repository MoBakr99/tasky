import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Screens/start_screen.dart';
import 'package:tasky/Screens/user_details_screen.dart';

import '../core/controllers/tasks_controller/task_model.dart';
import '../core/controllers/user_controller/user_controller.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<UserController, UserState>(
          builder: (context, userState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  SvgPicture.asset(
                    'assets/svg/avatar.svg',
                    width: 85,
                    height: 85,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFFFFFCFC), BlendMode.srcIn),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                        color: Color(0xFF282828),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: SvgPicture.asset(
                      'assets/svg/camera.svg',
                      width: 15,
                      height: 15,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFFFFFCFC), BlendMode.srcIn),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xFFC6C6C6)),
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
                    colorFilter: const ColorFilter.mode(
                        Color(0xFFFFFCFC), BlendMode.srcIn),
                  ),
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: SvgPicture.asset(
                    'assets/svg/arrow_right.svg',
                    width: 14,
                    height: 14,
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
                  ),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: const Color(0xfffffcfc),
                    activeTrackColor: Theme.of(context).colorScheme.primary,
                  ),
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
                  ),
                  title: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  trailing: SvgPicture.asset(
                    'assets/svg/arrow_right.svg',
                    width: 14,
                    height: 14,
                  ),
                  onTap: () {
                    context.read<UserController>().add(ChangeName(''));
                    context.read<UserController>().add(ChangeQuote(''));
                    Hive.box<Task>('tasks').clear();
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.clear();
                      },
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
