import 'package:flutter/material.dart';
import 'package:manifest/core/services/share_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({super.key, required this.url, this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String _currentUrl = '';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) => setState(() => _currentUrl = url),
        onPageFinished: (url) => setState(() => _currentUrl = url),
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),
          _SafariStyleBar(
            controller: _controller,
            currentUrl: _currentUrl,
          ),
        ],
      ),
    );
  }
}

class _SafariStyleBar extends StatelessWidget {
  final WebViewController controller;
  final String currentUrl;

  const _SafariStyleBar({
    required this.controller,
    required this.currentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => controller.goBack(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => controller.goForward(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => ShareService().shareMore(text: currentUrl),
          ),
        ],
      ),
    );
  }
}


