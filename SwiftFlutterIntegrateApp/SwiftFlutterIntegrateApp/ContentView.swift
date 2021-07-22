//
//  ContentView.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/20.
//

import SwiftUI

struct ContentView: View {
    let flutterVc = MyFlutterViewController()

    var body: some View {
        Text("Hello, Flutter!")
            .padding()
            .onTapGesture {
                flutterVc.showFlutter()
            }

        Text("Test method")
            .padding()
            .onTapGesture {
                FlutterEngineDelegate.methodChannel?.send(message: "method 123")
            }

        Text("Test basic")
            .padding()
            .onTapGesture {
                FlutterEngineDelegate.basicChannel?.send(message: "basic 12", callback: nil)
            }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewDevice("iPhone 12")
        }
    }
}
