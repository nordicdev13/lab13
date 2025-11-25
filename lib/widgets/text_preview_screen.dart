import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  final String previewText;
  final double fontSize;

  const PreviewScreen({
    super.key,
    required this.previewText,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'back_pressed');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  previewText,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, 'ok'),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                      ),
                      child: const Text('OK'),
                    ),

                    const SizedBox(width: 20),

                    OutlinedButton(
                      onPressed: () => Navigator.pop(context, 'cancel'),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(0, 48),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
