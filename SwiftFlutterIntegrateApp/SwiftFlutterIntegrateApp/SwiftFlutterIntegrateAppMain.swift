//
//  SwiftFlutterIntegrateAppApp.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/20.
//

import SwiftUI

@main
struct SwiftFlutterIntegrateAppMain: App {
    @UIApplicationDelegateAdaptor(FlutterEngineDelegate.self) var engineDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
