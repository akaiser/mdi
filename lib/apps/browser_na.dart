import 'package:flutter/material.dart';

class Browser extends StatelessWidget {
  const Browser({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        'Only supported on Web!',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
