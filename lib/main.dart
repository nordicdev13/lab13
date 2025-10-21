import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Color Slider Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key});

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  double red = 44;
  double green = 178;
  double blue = 230;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              color: Color.fromRGBO(
                red.toInt(),
                green.toInt(),
                blue.toInt(),
                1,
              ),
            ),
            const SizedBox(height: 32),


            buildColorSlider(
              label: "Red",
              value: red,
              color: Colors.red,
              onChanged: (value) => setState(() => red = value),
            ),

            buildColorSlider(
              label: "Green",
              value: green,
              color: Colors.green,
              onChanged: (value) => setState(() => green = value),
            ),

            buildColorSlider(
              label: "Blue",
              value: blue,
              color: Colors.blue,
              onChanged: (value) => setState(() => blue = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorSlider({
    required String label,
    required double value,
    required Color color,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${value.toInt()}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          min: 0,
          max: 255,
          value: value,
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
