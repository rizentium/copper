import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewLauncher extends StatefulWidget {
  final String title;
  final String url;

  const WebviewLauncher({super.key, required this.title, required this.url});

  @override
  State<WebviewLauncher> createState() => _WebviewLauncherState();
}

class _WebviewLauncherState extends State<WebviewLauncher> {
  late WebViewController controller;

  String get url {
    return 'https://${widget.url.replaceFirst(RegExp(r'https|http|ftp|https|ssh'), '')}';
  }

  bool? _forcePopScope;

  @override
  void initState() {
    _controllerInit(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () => _onCloseWindow(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: WebViewWidget(controller: controller),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  _onCloseWindow() {
    setState(() {
      _forcePopScope = true;
    });
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    if (_forcePopScope == true) {
      return true;
    }
    final canGoBack = await controller.canGoBack();
    if (canGoBack) {
      await controller.goBack();
      return false;
    }
    return true;
  }

  void _controllerInit(String url) {
    debugPrint(url);
    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint(progress.toString());
          },
          onPageStarted: (String url) {
            debugPrint('Started');
          },
          onPageFinished: (String url) {
            debugPrint('Finished');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.description);
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }
}
