import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ColorState(),
      child: const MyApp(),
    ),
  );
}


class ColorState extends ChangeNotifier {
  double _red = 44;
  double _green = 178;
  double _blue = 230;

  double get red => _red;
  double get green => _green;
  double get blue => _blue;

  Color get currentColor => Color.fromRGBO(
    _red.toInt(),
    _green.toInt(),
    _blue.toInt(),
    1,
  );

  void setRed(double value) {
    _red = value;
    notifyListeners();
  }

  void setGreen(double value) {
    _green = value;
    notifyListeners();
  }

  void setBlue(double value) {
    _blue = value;
    notifyListeners();
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo Home Page',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
        backgroundColor: Colors.purple[200],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPreview(),

            SizedBox(height: 32),
            ColorSlidersSection(),
          ],
        ),
      ),
    );
  }
}

class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.watch<ColorState>().currentColor;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    );
  }
}

class ColorSlidersSection extends StatelessWidget {
  const ColorSlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ColorState>();

    return Column(
      children: [
        _buildSingleSlider(
          label: "Red",
          value: state.red,
          onChanged: (val) => context.read<ColorState>().setRed(val),
        ),
        _buildSingleSlider(
          label: "Green",
          value: state.green,
          onChanged: (val) => context.read<ColorState>().setGreen(val),
        ),
        _buildSingleSlider(
          label: "Blue",
          value: state.blue,
          onChanged: (val) => context.read<ColorState>().setBlue(val),
        ),
      ],
    );
  }

  Widget _buildSingleSlider({
    required String label,
    required double value,
    required Function(double) onChanged,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color ?? Colors.black
              ),
            ),
            Text(
              value.toInt().toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          min: 0,
          max: 255,
          value: value,
          activeColor: color,
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}