import 'package:flutter/material.dart';
import 'package:supabase_auth/auth/auth_service.dart';

import 'package:supabase_auth/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get auth service
  final authsevice = AuthService();

  //text editiing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //loginButtoon pressed
  void login() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    //attemp the login
    try {
      await authsevice.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ERROR: $e")));
      }
    }
  }

//build the ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Login"),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          //email
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "email"),
          ),
          const SizedBox(height: 12),
          //password
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "password"),
          ),
          //button
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: login,
            child: const Text("login"),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: const Text("dont have a accont? Signup")),
        ],
      ),
    );
  }
}
