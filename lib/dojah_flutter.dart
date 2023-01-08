library dojah_flutter;

export 'utils.dart';

import 'package:dojah_flutter/utils.dart';
import 'package:flutter/material.dart';

import 'dojah_webview.dart';

class DojahFinancial {
  final String appId;
  final String publicKey;
  final DojahType type;
  final Map<String, dynamic>? metadata;

  DojahFinancial({
    required this.appId,
    required this.publicKey,
    required this.type,
    this.metadata,
  });

  /// This method calls the dojah widget
  ///
  /// [ctx] - is a required parameter
  ///
  /// [appId] - Required
  ///
  /// [publicKey] - Required
  ///
  /// [type] - Required
  ///
  /// [metadata] - Optional
  void open(
    BuildContext ctx, {
    Function(dynamic result)? onSuccess,
    Function(dynamic close)? onClose,
    Function(dynamic error)? onError,
  }) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => DojahWebView(
          appId: appId,
          publicKey: publicKey,
          type: type,
          metadata: metadata,
          success: (result) {
            onSuccess!(result);
          },
          close: (result) {
            onClose!(result);
          },
          error: (result) {
            onError!(result);
          },
        ),
      ),
    );
  }
}
