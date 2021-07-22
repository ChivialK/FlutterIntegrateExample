//
//  FlutterIntegrateMethodChannel.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/22.
//

import Flutter
import Foundation

class FlutterIntegrateMethodChannel {
    let binaryMessenger: FlutterBinaryMessenger
    let channelName = "flutter_integrate_module/method"
    var channel: FlutterMethodChannel?

    required init(messenger: FlutterBinaryMessenger) {
        binaryMessenger = messenger
        setMethodChannel()
    }

    private func setMethodChannel() {
        channel = FlutterMethodChannel(name: channelName, binaryMessenger: binaryMessenger)
        channel?.setMethodCallHandler({
            (call: FlutterMethodCall, _: FlutterResult) -> Void in
            print("method call: \(String(describing: call.method)) arg: \(String(describing: call.arguments))")
        })
    }

    func send(message: String) {
        channel?.invokeMethod("flutterMethod", arguments: message)
    }
}
