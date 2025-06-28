import 'package:flutter/material.dart';

class UrlTextField extends StatelessWidget {
  const UrlTextField(
    this.urlPrefix,
    this.textController, {
    required this.onSubmitted,
  });

  final String urlPrefix;
  final TextEditingController textController;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => TextField(
    controller: textController,
    onSubmitted: onSubmitted,
    decoration: InputDecoration(
      isDense: true,
      prefix: Text(urlPrefix),
      suffixIcon: const Icon(Icons.search),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.only(top: 11, left: 16),
    ),
  );
}
