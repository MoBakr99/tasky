import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final Function()? onBackButtonPressed;

  const MainAppBar({super.key, required this.title, this.onBackButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Colors.white,
        onPressed: onBackButtonPressed,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      titleSpacing: 0,
      toolbarHeight: 64,
    );
  }
}
