//
//  FlutterIntegrateBasicChannel.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/22.
//

import Flutter
import Foundation

class FlutterIntegrateBasicChannel {
    let binaryMessenger: FlutterBinaryMessenger
    let channelName = "flutter_integrate_module/basic"
    var channel: FlutterBasicMessageChannel?

    required init(messenger: FlutterBinaryMessenger) {
        binaryMessenger = messenger
        setBasicChannel()
    }

    private func setBasicChannel() {
        channel = FlutterBasicMessageChannel(name: channelName,
                                             binaryMessenger: binaryMessenger,
                                             codec: FlutterStandardMessageCodec.sharedInstance())
        channel?.setMessageHandler({ (message: Any?, _: @escaping FlutterReply) -> Void in
            let str = message as? String ?? ""
            print("basic call: \(str)")
            if (str == "reset") {
                FlutterEngineDelegate.eventChannel?.resetCountdown()
            }
        })
    }

    func send(message: Any, callback: FlutterReply?) {
        channel?.sendMessage(message, reply: callback)
    }
}
