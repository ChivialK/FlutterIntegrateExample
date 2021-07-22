//
//  FlutterIntegrateEventChannel.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/22.
//

import Flutter
import Foundation

class FlutterIntegrateEventChannel {
    let binaryMessenger: FlutterBinaryMessenger
    let channelName = "flutter_integrate_module/event"

    var channel: FlutterEventChannel?
    private lazy var handler: EventHandler = EventHandler()
    var countdownTimer: Timer?
    var countdown = 15

    required init(messenger: FlutterBinaryMessenger) {
        binaryMessenger = messenger
        channel = FlutterEventChannel(name: channelName, binaryMessenger: binaryMessenger)
        channel?.setStreamHandler(handler)
    }
    
    func resetHandler() {
        let newHandler = EventHandler()
        handler = newHandler
        channel?.setStreamHandler(newHandler)
    }

    func resetCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdown > 0 {
                print("\(self.countdown) seconds")
                self.countdown -= 1
                self.handler.sink(message: self.countdown)
            } else {
                timer.invalidate()
            }
        }
    }
    
    /*
     * The FlutterStreamHandler is not working with class inherit.
     * Create an instance to and pass it to [setStreamHandler] works.
     * Maybe it's because the FlutterViewController is not created in FlutterAppDelegate?
     */
    class EventHandler: NSObject, FlutterStreamHandler {
        private var channelSink: FlutterEventSink?
        
        func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            print("onListen event channel")
            channelSink = events
            return nil
        }

        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            print("onCancel event channel")
            channelSink = nil
            return nil
        }
        
        func sink(message: Any?) {
            guard channelSink != nil else {
                print("FlutterEventSink is nil!!")
                return
            }
            if message != nil {
                channelSink?(message)
            }
        }
    }
}
