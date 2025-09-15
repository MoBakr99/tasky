import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/widgets/main_app_bar.dart';

import '../core/controllers/user_controller/user_controller.dart';
import '../core/widgets/custom_form_field.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  bool _isValidName(String name) =>
      (!name.contains(RegExp(r'[^a-zA-Z\sء-ي]')) && name.length >= 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: MainAppBar(title: 'User Details')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: BlocBuilder<UserController, UserState>(
              builder: (BuildContext context, UserState userState) {
                _taskNameController.text = userState.name;
                _taskDescriptionController.text = userState.quote;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomFormField(
                        fieldTitle: 'User Name',
                        hintText: 'Enter your name',
                        controller: _taskNameController,
                        border: true,
                        validator: (value) => (value == null ||
                                value.trim().isEmpty)
                            ? 'Please enter your name'
                            : (!_isValidName(value.trim()))
                                ? 'Name must be at least 3 letters without special characters'
                                : null,
                      ),
                      const SizedBox(height: 20),
                      CustomFormField(
                        fieldTitle: 'Motivation Quote',
                        hintText: 'Enter a quote that motivates you',
                        controller: _taskDescriptionController,
                        maxLines: 5,
                        border: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a motivation quote';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: BlocBuilder<UserController, UserState>(
            builder: (BuildContext context, UserState userState) {
              return FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<UserController>()
                        .add(ChangeName(_taskNameController.text.trim()));
                    context.read<UserController>().add(
                        ChangeQuote(_taskDescriptionController.text.trim()));
                    SharedPreferences.getInstance().then(
                      (prefs) {
                        prefs.setString('username', userState.name);
                        prefs.setString('quote', userState.quote);
                      },
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 10),
                    Text(
                      'Save Changes',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: const Color(0xfffffcfc)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
