//
//  FlutterViewController.swift
//  SwiftFlutterIntegrateApp
//
//  Created by Raven_Chiang on 2021/7/21.
//

import UIKit
import Flutter

class MyFlutterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
    }

    @objc func showFlutter() {
        let flutterEngine = FlutterEngineDelegate.shared?.engine
        if (flutterEngine != nil) {
            let topViewController = UIApplication.shared.windows.first?.rootViewController
            let flutterViewController =
                FlutterViewController(engine: flutterEngine!, nibName: nil, bundle: nil)
            topViewController?.present(flutterViewController, animated: true, completion: nil)
        }
    }
}

