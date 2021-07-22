//
//  AppDelegate.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/20.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

//@UIApplicationMain
class FlutterEngineDelegate: FlutterAppDelegate {
    
    lazy var engine = FlutterEngine(name: "newFlutterEngine")
    static var shared: FlutterEngineDelegate?
    static var methodChannel: FlutterIntegrateMethodChannel?
    static var basicChannel: FlutterIntegrateBasicChannel?
    static var eventChannel: FlutterIntegrateEventChannel?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Self.shared = self
        
        // Runs the default Dart entrypoint with a default Flutter route.
        engine.run();
        
        // setup flutter channels
        Self.methodChannel = FlutterIntegrateMethodChannel(messenger: engine.binaryMessenger)
        Self.basicChannel = FlutterIntegrateBasicChannel(messenger: engine.binaryMessenger)
        Self.eventChannel = FlutterIntegrateEventChannel(messenger: engine.binaryMessenger)
        
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.engine);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}

