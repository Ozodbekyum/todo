import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/overview_screen.dart';

import '../providers/shared_preferences.dart';

enum AuthMode {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'Auth-Screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.signIn;

  void _confirmAuth() async {
    if (!_formState.currentState!.validate()) {
      return;
    }
    if(_authMode == AuthMode.signUp) {
      
      await Provider.of<SharedPrefs>(context, listen: false).addUser(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text,
      );
    }else{
      await Provider.of<SharedPrefs>(context, listen: false).addUser(
        context: context,
        username: _usernameController.text,
        password: _passwordController.text,
      );
    }
    context.goNamed(OverviewScreen.routeName);
  }

  void _changeAuth() {
    if (_authMode == AuthMode.signIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.signIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formState,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              txtfield(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter username';
                  }
                  return null;
                },
                hint: 'Enter username',
              ),
              const SizedBox(height: 15),
              txtfield(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter password';
                  } else if (value.length < 8) {
                    return 'Password is very weak';
                  }
                  return null;
                },
                hint: 'Enter password',
              ),
              const SizedBox(height: 15),
              if (_authMode == AuthMode.signUp)
                txtfield(
                  controller: _confirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, enter password again';
                    } else if (value != _passwordController.text) {
                      return 'Please, check your password';
                    }
                    return null;
                  },
                  hint: 'Confirm password',
                ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: _changeAuth,
                    child: Text(
                      _authMode == AuthMode.signIn ? 'SignUp' : 'SignIn',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _confirmAuth,
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField txtfield({
    required String? Function(String? value) validator,
    required TextEditingController controller,
    required String hint,
    bool isTheLast = false,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      textInputAction: isTheLast ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.black12,
      ),
    );
  }
}
