import 'package:flutter/material.dart';

class BookmarksBar extends StatelessWidget {
  const BookmarksBar({required this.onItemPressed});

  final void Function(String) onItemPressed;

  @override
  Widget build(BuildContext context) => ListView(
    scrollDirection: Axis.horizontal,
    children: [
      const SizedBox(width: 8),
      _Button('MDI', onPressed: () => onItemPressed('akaiser.github.io/mdi/')),
      _Button(
        'Velik',
        onPressed: () => onItemPressed('akaiser.github.io/velik/'),
      ),
      _Button(
        'Swipe Overlays',
        onPressed: () => onItemPressed('akaiser.github.io/swipe_overlays/'),
      ),
      _MicroStudioButton(
        text: 'MS Roller coaster',
        urlSuffix: 'gilles/roadworks/',
        onPressed: onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Wormhole',
        urlSuffix: 'TinkerSmith/wormhole/',
        onPressed: onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS ChipToy S1',
        urlSuffix: 'gilles/chiptoys1/',
        onPressed: onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Doodle',
        urlSuffix: 'gilles/doodlemulti/',
        onPressed: onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Racing Demo',
        urlSuffix: 'gilles/racingdemo/',
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
  Widget build(BuildContext context) =>
      _Button(text, onPressed: () => onPressed('$_urlPrefix/$urlSuffix'));
}

class _Button extends StatelessWidget {
  const _Button(this.text, {required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );
}
