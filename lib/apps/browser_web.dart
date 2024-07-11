import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

const _httpsSchema = 'https://';
const _initPage = 'flutter.dev';

// check
// https://github.com/alibaba/flutter_boost/blob/04f44f66a10ede905f1b67d37556d890c38f89c7/example/lib/case/webview_flutter_demo.dart

class Browser extends StatefulWidget {
  const Browser();

  @override
  State<Browser> createState() => _BrowserNewState();
}

class _BrowserNewState extends State<Browser> {
  late final TextEditingController _textController;
  late final PlatformWebViewController _webController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _webController = WebWebViewController(WebWebViewControllerCreationParams());

    _loadPage(_initPage);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _loadPage(String value) {
    if (value.isNotEmpty) {
      var uri = Uri.tryParse(value);
      if (uri != null) {
        if (!uri.hasScheme) {
          uri = Uri.parse('$_httpsSchema$value');
        }
        _webController.loadRequest(LoadRequestParams(uri: uri));
        _textController.text = _iFrameSrc;
      }
    } else {
      _textController.text = _iFrameSrc;
    }
  }

  String get _iFrameSrc {
    final params = _webController.params as WebWebViewControllerCreationParams;
    // ignore: invalid_use_of_visible_for_testing_member
    return params.iFrame.src.split(_httpsSchema.substring(5)).last;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              _RefreshButton(onPressed: () => _loadPage(_iFrameSrc)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: _TextField(_textController, onSubmitted: _loadPage),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: WebWebViewWidget(
              PlatformWebViewWidgetCreationParams(controller: _webController),
            ).build(context),
          ),
        ],
      );
}

class _TextField extends StatelessWidget {
  const _TextField(this.textController, {required this.onSubmitted});

  final TextEditingController textController;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) => TextField(
        controller: textController,
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          isDense: true,
          prefix: Text(_httpsSchema),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 11, left: 16),
        ),
      );
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.replay, color: Colors.white),
        onPressed: onPressed,
      );
}
