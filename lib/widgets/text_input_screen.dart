import 'package:flutter/material.dart';
import 'text_preview_screen.dart';

class TextPreviewerScreen extends StatefulWidget {
  const TextPreviewerScreen({super.key});

  @override
  State<TextPreviewerScreen> createState() => _TextPreviewerScreenState();
}

class _TextPreviewerScreenState extends State<TextPreviewerScreen> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _fontSize = 16.0;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _navigateToPreview() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(
            previewText: _textController.text,
            fontSize: _fontSize,
          ),
        ),
      );

      if (result != null && mounted) {
        _handleReturnedResult(result);
      }
    }
  }

  void _handleReturnedResult(String code) {
    String title = '';
    String imageUrl = 'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090';

    if (code == 'ok') {
      title = 'Cool';
    } else if (code == 'cancel') {
      title = "Let's try something else";
    } else if (code == 'back_pressed') {
      title = "Don't know what to say";
    }

    _showImageDialog(title, imageUrl);
  }

  void _showImageDialog(String title, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              imageUrl,
              height: 60,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, size: 50),
              loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(child: CircularProgressIndicator())
                );
              },
            ),

            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text previewer'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Text',
                      hintText: 'Enter some text',
                    ),
                    maxLines: 1,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Поле не може бути пустим';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const Text('Font size:', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 10),
                      Text(
                        '${_fontSize.toInt()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: _fontSize,
                          min: 10.0,
                          max: 100.0,
                          divisions: 90,
                          onChanged: (double value) {
                            setState(() {
                              _fontSize = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: _navigateToPreview,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      child: const Text('Preview'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
