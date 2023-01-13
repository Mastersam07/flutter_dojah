import 'dart:convert';

import 'package:dojah_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DojahWebView extends StatefulWidget {
  const DojahWebView({
    Key? key,
    required this.success,
    required this.error,
    required this.close,
    required this.publicKey,
    required this.appId,
    required this.type,
    this.metadata,
    this.userdata,
  }) : super(key: key);

  final Function(dynamic) success;
  final Function(dynamic) error;
  final Function(dynamic) close;
  final String publicKey;
  final String appId;
  final DojahType type;
  final UserData? userdata;
  final Map<String, dynamic>? metadata;

  @override
  State<DojahWebView> createState() => _DojahWebViewState();
}

class _DojahWebViewState extends State<DojahWebView> {
  InAppWebViewController? _myController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
        clearCache: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dojah Financial'),
      ),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(
          baseUrl: Uri.parse("https://widget.dojah.io"),
          androidHistoryUrl: Uri.parse("https://widget.dojah.io"),
          mimeType: "text/html",
          data: """
                    <html lang="en">
                      <head>
                          <meta charset="UTF-8">
                              <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, shrink-to-fit=1"/>
                            
                          <title>Dojah Inc.</title>
                      </head>
                      <body>
                
                      <script src="https://widget.dojah.io/widget.js"></script>
                      <script>
                                const options = {
                                    app_id: "${widget.appId}",
                                    p_key: "${widget.publicKey}",
                                    type: "${widget.type.name}",
                                    metadata: ${json.encode(widget.metadata ?? {})},
                                    user_data: ${json.encode(widget.userdata?.toJson() ?? {})},
                                    config: {
                                      debug: false,
                                      aml: false,
                                      webhook: true,
                                      review_process: "${ReviewType.Automatic.name}",
                                      strictness_level: 'high', 
                                      pages: [
                                            { page: 'user-data', config: { enabled: true } },
                                            { page: 'countries', config: { enabled: false } },
                                            { page: 'id', config: { nin: true, passport: true, dl: true, custom: true } },
                                          ],
                                    },
                                    onSuccess: function (response) {
                                    window.flutter_inappwebview.callHandler('onSuccessCallback', response)
                                    },
                                    onError: function (err) {
                                      window.flutter_inappwebview.callHandler('onErrorCallback', error)
                                    },
                                    onClose: function () {
                                      window.flutter_inappwebview.callHandler('onCloseCallback', 'close')
                                    }
                                }
                                  const connect = new Connect(options);
                                  connect.setup();
                                  connect.open();
                            </script>
                      </body>
                    </html>
                """,
        ),
        initialUrlRequest:
            URLRequest(url: Uri.parse("https://widget.dojah.io")),
        initialOptions: options,
        onWebViewCreated: (controller) async {
          _myController = controller;

          _myController?.addJavaScriptHandler(
            handlerName: 'onSuccessCallback',
            callback: (response) {
              widget.success(response);
            },
          );

          _myController?.addJavaScriptHandler(
            handlerName: 'onCloseCallback',
            callback: (response) {
              widget.close(response);
              if (response.first == 'close') {
                Navigator.pop(context);
              }
            },
          );

          _myController?.addJavaScriptHandler(
            handlerName: 'onErrorCallback',
            callback: (error) {
              widget.error(error);
            },
          );
        },
      ),
    );
  }
}
