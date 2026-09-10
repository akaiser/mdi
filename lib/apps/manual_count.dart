import 'package:flutter/material.dart';

class const ManualCount({super.key}) extends StatefulWidget {
  @override
  State<ManualCount> createState() => _ManualCountState();
}

class _ManualCountState extends State<ManualCount> {
  var _count = 0;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    mainAxisSize: .min,
    children: [
      Text(
        '$_count',
        style: const TextStyle(fontSize: 32, color: Colors.white),
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          ElevatedButton(
            onPressed: () => setState(() => --_count),
            child: const Text('-'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => ++_count),
            child: const Text('+'),
          ),
        ],
      ),
    ],
  );
}
