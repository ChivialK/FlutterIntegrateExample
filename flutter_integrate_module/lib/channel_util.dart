import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart';

class ChannelUtil {
  static const myMethodChannel =
      const MethodChannel('flutter_integrate_module/method');
  static const myBasicChannel = const BasicMessageChannel(
      'flutter_integrate_module/basic', StandardMessageCodec());
  static const myEventChannel =
      const EventChannel('flutter_integrate_module/event');

  static const testMethodName = 'flutterMethod';

  /// [onReceivedMethod] to receive and react on method channel message from native
  /// [onReceivedBasic] to receive and react on basic channel message from native
  static start({
    Future<dynamic> Function(dynamic)? onReceivedMethod,
    Future<String> Function(String)? onReceivedBasic,
  }) {
    /// [invokeMethod] send message through channel
    myMethodChannel.invokeMethod(testMethodName, '');
    myMethodChannel.setMethodCallHandler((call) {
      debugPrint('channel /method received message: $call');
      return onReceivedMethod?.call(call.arguments) ?? Future.value();
    });

    myBasicChannel.setMessageHandler((message) {
      debugPrint('channel /method received message: $message');
      return onReceivedBasic?.call('received: "$message"') ?? Future.value();
    });
  }

  static Stream startStream() {
    final stream = myEventChannel.receiveBroadcastStream().distinct();
    stream.listen((event) {
      debugPrint('channel /event received message: $event');
    });
    return stream;
  }

  static sendAsMethod(String message) {
    myMethodChannel.invokeMethod(testMethodName, message);
  }

  static sendAsBasic(String message) {
    debugPrint('sending message to basic: $myBasicChannel');
    myBasicChannel.send(message);
  }
}
