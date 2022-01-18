import 'dart:async' show Stream, StreamController;

import 'package:flutter/material.dart';

const _backgroundColor = Color.fromRGBO(42, 31, 62, 1);
const _textColor = Color.fromRGBO(255, 255, 255, 1);

const _buttonColorMisc = Color.fromRGBO(72, 55, 103, 1);
const _buttonColorNumber = Color.fromRGBO(103, 88, 128, 1);
const _buttonColorOperation = Color.fromRGBO(255, 159, 11, 1);

const _unicodeMappings = {
  '/': '\u00f7',
  '*': '\u00d7',
  '-': '\u2212',
  '+': '\u002b',
  '=': '\u003d',
};

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _value = '0';
  late StreamController<String> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = StreamController();
  }

  @override
  void dispose() {
    _valueNotifier.close();
    super.dispose();
  }

  void _addValue(String value) {
    if (_value == '0') {
      if (['1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(value)) {
        _value = value;
      } else if (value == ',' || _unicodeMappings.containsValue(value)) {
        _value += value;
      }
    } else if (value == 'C') {
      _value = '0';
    } else if (value == '=') {
      _value = '42'; // TODO :)
    } else {
      _value += value;
    }

    _valueNotifier.sink.add(_value);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: _Output(_valueNotifier.stream),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button('C', _ButtonType.misc, _addValue),
                const _Button('', _ButtonType.misc, null),
                const _Button('', _ButtonType.misc, null),
                _Button(
                  _unicodeMappings['/']!,
                  _ButtonType.operation,
                  _addValue,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button('7', _ButtonType.number, _addValue),
                _Button('8', _ButtonType.number, _addValue),
                _Button('9', _ButtonType.number, _addValue),
                _Button(
                  _unicodeMappings['*']!,
                  _ButtonType.operation,
                  _addValue,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button('4', _ButtonType.number, _addValue),
                _Button('5', _ButtonType.number, _addValue),
                _Button('6', _ButtonType.number, _addValue),
                _Button(
                  _unicodeMappings['-']!,
                  _ButtonType.operation,
                  _addValue,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button('1', _ButtonType.number, _addValue),
                _Button('2', _ButtonType.number, _addValue),
                _Button('3', _ButtonType.number, _addValue),
                _Button(
                  _unicodeMappings['+']!,
                  _ButtonType.operation,
                  _addValue,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button('0', _ButtonType.number, _addValue, flex: 2),
                _Button(',', _ButtonType.number, _addValue),
                _Button(
                  _unicodeMappings['=']!,
                  _ButtonType.operation,
                  _addValue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Output extends StatelessWidget {
  const _Output(
    this.valueStream, {
    Key? key,
  }) : super(key: key);

  final Stream<String> valueStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: valueStream,
      builder: (context, snapshot) => Text(
        snapshot.hasData ? '${snapshot.data}' : '0',
        style: const TextStyle(
          fontSize: 44,
          color: _textColor,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }
}

enum _ButtonType { number, operation, misc }

class _Button extends StatelessWidget {
  const _Button(
    this.text,
    this.buttonType,
    this.onPressed, {
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  final String text;
  final int flex;
  final _ButtonType? buttonType;
  final Function(String value)? onPressed;

  Color get buttonColor {
    switch (buttonType) {
      case _ButtonType.operation:
        return _buttonColorOperation;
      case _ButtonType.misc:
        return _buttonColorMisc;
      default:
        return _buttonColorNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: TextButton(
        onPressed: onPressed != null ? () => onPressed!(text) : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateProperty.all(_textColor),
          backgroundColor: MaterialStateProperty.all(buttonColor),
          side: MaterialStateProperty.all(
            const BorderSide(
              width: 0.3,
              color: _backgroundColor,
            ),
          ),
          shape: MaterialStateProperty.all(const BeveledRectangleBorder()),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: buttonType == _ButtonType.operation ? 24 : 20,
            fontWeight: buttonType == _ButtonType.operation
                ? FontWeight.normal
                : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
