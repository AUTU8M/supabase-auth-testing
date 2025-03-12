import 'package:flutter/material.dart';
import 'package:supabase_auth/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth service
  final authsevice = AuthService();

  //text editiing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  //loginButtoon pressed
  void signUp() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmpassword = _confirmpasswordController.text;

    //check the password match
    if (password != confirmpassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password do not match")));
      return;
    }
    //attempt signup
    try {
      await authsevice.signUpWithEmailPassword(email, password);

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ERROR: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
            obscureText: true,
          ),
          const SizedBox(height: 12),
          //confirm password
          TextField(
            controller: _confirmpasswordController,
            decoration: const InputDecoration(labelText: "confirm password"),
            obscureText: true,
          ),
          //button
          ElevatedButton(
            onPressed: signUp,
            child: const Center(child: Text("Sign up")),
          ),
        ],
      ),
    );
  }
}
