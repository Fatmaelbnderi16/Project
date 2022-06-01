import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webView extends StatefulWidget {
  var pickedImage;

  webView({Key? key, required this.pickedImage}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<webView> {
  String finaltext = "";
  bool loading = true;

  late WebViewController controllerGlobal;

  late WebViewController _controller;
  bool isLoading = true;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  getTextFromImage() async {
    final GoogleVisionImage visionImage =
        GoogleVisionImage.fromFile(widget.pickedImage);
    final TextRecognizer textRecognizer =
        GoogleVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);
    finaltext = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        finaltext = finaltext + line.text.toString();
      }
    }
    setState(() {
      finaltext = finaltext.replaceAll(" ", "+");
      loading = false;
    });
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void initState() {
    getTextFromImage();
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(finaltext.replaceAll("+", " ")),
      ),
      body: loading
          ? const Center(
              child: Text(
                'Processing...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : Stack(
              children: [
                SafeArea(
                  child: WillPopScope(
                    onWillPop: () => _goBack(context),
                    child: WebView(
                      initialUrl: "https://www.amazon.com/s?k=$finaltext",
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controllerCompleter.future
                            .then((value) => _controller = value);
                        _controllerCompleter.complete(webViewController);
                      },
                      onProgress: (int progress) {
                        // Removes header and footer from page
                        _controller.runJavascript(
                            "javascript:(function() { var head = document.getElementsByTagName('header')[0];head.parentNode.removeChild(head);})()");
                        _controller.runJavascript(
                            "javascript:(function() { var footer = document.getElementsByTagName('footer')[0];footer.parentNode.removeChild(footer);})()");
                        _controller.runJavascript(
                            "javascript:(document.addEventListener('click', function(event) {  event.preventDefault();});)()");
                        _controller.runJavascript(
                            "document.getElementById('buybox.addToCart').style.display = 'none';");
                        _controller.runJavascript(
                            "document.getElementById('exports_mobile_qualified_buybox_buyNow_feature_div').style.display = 'none';");
                        /* _controller
                              .runJavascript(
                                  "javascript:(document.addEventListener('click', function(event) {" +
                                      "event.preventDefault();" +
                                      "});)()")
                              .then((value) =>
                                  debugPrint('Page finished loading onclick'))
                              .catchError((onError) => debugPrint('$onError')); */
                      },
                      onPageStarted: (String url) {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      onPageFinished: (String url) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack()
              ],
            ),
    );
  }
}
