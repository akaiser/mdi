import 'package:flutter/material.dart';

class BookmarksBar extends StatelessWidget {
  const BookmarksBar({required this.onItemPressed});

  final void Function(String) onItemPressed;

  @override
  Widget build(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 8),
          TextButton(
            child: const Text('MDI'),
            onPressed: () => onItemPressed('github.com/akaiser/mdi'),
          ),
          _MicroStudioButton(
            text: 'MS Roller coaster',
            urlSuffix: 'gilles/roadworks',
            onPressed: onItemPressed,
          ),
          _MicroStudioButton(
            text: 'MS Wormhole',
            urlSuffix: 'TinkerSmith/wormhole/',
            onPressed: onItemPressed,
          ),
          _MicroStudioButton(
            text: 'MS ChipToy S1',
            urlSuffix: 'gilles/chiptoys1',
            onPressed: onItemPressed,
          ),
          _MicroStudioButton(
            text: 'MS Doodle',
            urlSuffix: 'gilles/doodlemulti',
            onPressed: onItemPressed,
          ),
          _MicroStudioButton(
            text: 'MS Racing Demo',
            urlSuffix: 'gilles/racingdemo',
            onPressed: onItemPressed,
          ),
          const SizedBox(width: 8),
        ],
      );
}

class _MicroStudioButton extends StatelessWidget {
  const _MicroStudioButton({
    required this.text,
    required this.urlSuffix,
    required this.onPressed,
  });

  final String text;
  final String urlSuffix;
  final void Function(String) onPressed;

  static const _urlPrefix = 'microstudio.io';

  @override
  Widget build(BuildContext context) => TextButton(
        child: Text(text),
        onPressed: () => onPressed('$_urlPrefix/$urlSuffix'),
      );
}
