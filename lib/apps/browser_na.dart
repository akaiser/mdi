import 'package:flutter/material.dart';

class const Browser({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: .all(8),
      child: Text(
        'Only supported on Web!',
        textAlign: .center,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
