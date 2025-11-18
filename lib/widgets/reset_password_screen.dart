import 'package:flutter/material.dart';
import './sign_in_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            const TextField(),

            const SizedBox(height: 24.0),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const AlertDialog(
                    title: Text("Message"),
                    content: Text("Need to implement"),
                  ),
                );
              },
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
    );
  }
}
