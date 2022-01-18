import 'dart:async' show Timer;

import 'package:flutter/widgets.dart';

class AutoCount extends StatefulWidget {
  const AutoCount({Key? key}) : super(key: key);

  @override
  _AutoCountState createState() => _AutoCountState();
}

class _AutoCountState extends State<AutoCount> {
  int _count = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => setState(() => _count = timer.tick),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$_count',
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}
