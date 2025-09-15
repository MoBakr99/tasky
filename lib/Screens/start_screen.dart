import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/controllers/user_controller/user_controller.dart';
import '../core/widgets/custom_form_field.dart';
import 'main_screen.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  bool _isValidName(String name) {
    return (!name.contains(RegExp(r'[^a-zA-Z\sء-ي]')) && name.length >= 3);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserController, UserState>(
        builder: (BuildContext context, UserState userState) => Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/svg/vector.svg',
                              width: 42,
                              height: 42,
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Tasky',
                              style: Theme.of(context).textTheme.headlineLarge,
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Welcome to Tasky',
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              'assets/svg/waving_hand.svg',
                              width: 28,
                              height: 28,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your productivity journey starts here.',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset('assets/svg/pana.svg'),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomFormField(
                              fieldTitle: 'Full Name',
                              hintText: 'e.g. Sarah Khalid',
                              controller: _nameController,
                              autofocus: true,
                              validator: (value) =>
                                  (value == null || value.trim().isEmpty)
                                      ? 'Please enter your name'
                                      : (!_isValidName(value.trim()))
                                          ? 'Name must be at least 3 letters'
                                          : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  userState.name = _nameController.text.trim();
                                  userState.quote =
                                      'One Task at a Time.One Step Closer.';
                                  SharedPreferences.getInstance().then(
                                    (prefs) {
                                      prefs.setString(
                                          'username', userState.name);
                                      prefs.setString('quote', userState.quote);
                                    },
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen()));
                                }
                              },
                              child: const Text(
                                "Let's Get Started",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
