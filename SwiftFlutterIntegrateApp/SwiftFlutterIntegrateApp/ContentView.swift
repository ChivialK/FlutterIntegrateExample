//
//  ContentView.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/20.
//

import UIKit
import SwiftUI
import Flutter

struct ContentView: View {
    @State private var isShowingDetailView = false
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: MyFlutterView(), isActive: $isShowingDetailView) {
                Text("show flutter")
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isShowingDetailView = false
            }
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

struct MyFlutterView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FlutterViewController {
        FlutterViewController(engine: FlutterEngineDelegate.shared!.engine, nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}
    
//    typealias UIViewControllerType = MyFlutterViewController
}
