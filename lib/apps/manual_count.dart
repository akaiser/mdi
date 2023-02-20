import 'package:flutter/material.dart';

class ManualCount extends StatefulWidget {
  const ManualCount({super.key});

  @override
  State<ManualCount> createState() => _ManualCountState();
}

class _ManualCountState extends State<ManualCount> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$_count',
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
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
          )
        ],
      );
}
