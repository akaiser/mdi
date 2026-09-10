import 'package:flutter/material.dart';

class const BookmarksBar({
  required final ValueSetter<String> _onItemPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
    scrollDirection: .horizontal,
    children: [
      const SizedBox(width: 8),
      _Button('MDI', onPressed: () => _onItemPressed('akaiser.github.io/mdi/')),
      _Button(
        'Velik',
        onPressed: () => _onItemPressed('akaiser.github.io/velik/'),
      ),
      _Button(
        'Swipe Overlays',
        onPressed: () => _onItemPressed('akaiser.github.io/swipe_overlays/'),
      ),
      _MicroStudioButton(
        text: 'MS Roller coaster',
        urlSuffix: 'gilles/roadworks/',
        onPressed: _onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Wormhole',
        urlSuffix: 'TinkerSmith/wormhole/',
        onPressed: _onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS ChipToy S1',
        urlSuffix: 'gilles/chiptoys1/',
        onPressed: _onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Doodle',
        urlSuffix: 'gilles/doodlemulti/',
        onPressed: _onItemPressed,
      ),
      _MicroStudioButton(
        text: 'MS Racing Demo',
        urlSuffix: 'gilles/racingdemo/',
        onPressed: _onItemPressed,
      ),
      const SizedBox(width: 8),
    ],
  );
}

class const _MicroStudioButton({
  required final String _text,
  required final String _urlSuffix,
  required final void Function(String) _onPressed,
}) extends StatelessWidget {
  static const _urlPrefix = 'microstudio.io';

  @override
  Widget build(BuildContext context) =>
      _Button(_text, onPressed: () => _onPressed('$_urlPrefix/$_urlSuffix'));
}

class const _Button(
  final String _text, {
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: _onPressed,
    child: Text(_text, style: const TextStyle(color: Colors.white)),
  );
}
