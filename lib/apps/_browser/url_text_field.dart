import 'package:flutter/material.dart';

class const UrlTextField(
  final String _urlPrefix,
  final TextEditingController _textController, {
  required final ValueChanged<String>? _onSubmitted,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextField(
    controller: _textController,
    onSubmitted: _onSubmitted,
    decoration: InputDecoration(
      isDense: true,
      prefix: Text(_urlPrefix),
      suffixIcon: const Icon(Icons.search),
      border: InputBorder.none,
      contentPadding: const .only(top: 11, left: 16),
    ),
  );
}
