import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class BloodBankPage extends StatefulWidget {
  const BloodBankPage({super.key});

  @override
  State<BloodBankPage> createState() => _BloodBankPageState();
}

class _BloodBankPageState extends State<BloodBankPage> {
  final url = 'https://nbts.health.gov.lk/blood-bank-map/';
  late final WebViewController _webViewController;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) => setState(() => _isLoading = true),
          onPageFinished: (String url) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _webViewController),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
