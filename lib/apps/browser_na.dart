import 'package:material_ui/material_ui.dart';

class const Browser({super.key}) extends Center {
  this
    : super(
        child: const Padding(
          padding: .all(8),
          child: Text(
            'Only supported on Web!',
            textAlign: .center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
