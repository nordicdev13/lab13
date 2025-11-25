import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Додаємо імпорт Dio
import './sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();

  final Dio dio = Dio();

  bool isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await dio.post(
          'https://lab12.requestcatcher.com/reset_password',
          data: {
            "email": emailCtrl.text,
            "action": "reset_password_request"
          },
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Помилка з'єднання: $e")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/1024px-Google-flutter-logo.svg.png",
                  width: 200,
                ),
              ),

              const SizedBox(height: 24),

              Center(
                child: Text("Reset password", style: Theme.of(context).textTheme.titleMedium),
              ),

              const SizedBox(height: 24),

              const Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),

              TextFormField(
                controller: emailCtrl,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Поле не може бути пустим";
                  }
                  if (!isValidEmail(value.trim())) {
                    return "Некоректний email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: _resetPassword,
                child: const Text("Reset"),
              ),

              const SizedBox(height: 24.0),

              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}