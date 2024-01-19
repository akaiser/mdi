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
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late final ValueNotifier<String> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier('0');
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  void _addValue(String value) {
    var newValue = _valueNotifier.value;
    if (newValue == '0') {
      if (['1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(value)) {
        newValue = value;
      } else if (value == ',' || _unicodeMappings.containsValue(value)) {
        newValue += value;
      }
    } else if (value == 'C') {
      newValue = '0';
    } else if (value == '=') {
      newValue = '42'; // :)
    } else {
      newValue += value;
    }

    _valueNotifier.value = newValue;
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: _backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: _Output(_valueNotifier),
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

class _Output extends StatelessWidget {
  const _Output(this.valueNotifier);

  final ValueNotifier<String> valueNotifier;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String>(
        valueListenable: valueNotifier,
        builder: (context, value, _) => Text(
          value,
          style: const TextStyle(
            fontSize: 44,
            color: _textColor,
            fontWeight: FontWeight.w200,
          ),
        ),
      );
}

enum _ButtonType { number, operation, misc }

class _Button extends StatelessWidget {
  const _Button(
    this.text,
    this.buttonType,
    this.onPressed, {
    this.flex = 1,
  });

  final String text;
  final int flex;
  final _ButtonType? buttonType;
  final ValueSetter<String>? onPressed;

  Color get buttonColor {
    switch (buttonType) {
      case null:
      case _ButtonType.number:
        return _buttonColorNumber;
      case _ButtonType.operation:
        return _buttonColorOperation;
      case _ButtonType.misc:
        return _buttonColorMisc;
    }
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = this.onPressed;
    return Expanded(
      flex: flex,
      child: TextButton(
        onPressed: onPressed != null ? () => onPressed(text) : null,
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
