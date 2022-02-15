# 原生專案+Flutter SDK+跨平台溝通範例

## Android Kotlin /KotlinFlutterIntegrationTest
* Flutter熱啟動 /app/src/main/java/com/hcchiang/flutterintegrationtest/FlutterIntegrateApp.kt
* Flutter畫面&Android端跨平台訊息通道類 /app/src/main/java/com/hcchiang/flutterintegrationtest/ui/flutter

## iOS Swift專案 /SwiftFlutterIntegrateApp
* 用`.xcworkspace`開
* iOS入口 SwiftFlutterIntegrateAppMain.swift
* iOS主畫面 ContentView.swift
* Flutter引擎設定&iOS端跨平台訊息通道設定 FlutterEngineDelegate.swift 
* Flutter跨平台訊息通道類 /FlutterControl/xxxChannel.swift
* Button顯示Flutter畫面 /FlutterControl/FlutterViewController.swift

## Flutter專案 /flutter_integrate_module
```text
FlutterApp
 ├── /lib // Production Code
 │     └── main.dart // Dart預設入口
 │     ├── app_router.dart // 頁面導航
 │     │     └── app_router.gr.dart // 編譯產生的檔案
 │     ├── empty_page.dart // 導航失敗畫面
 │     └── channel_util.dart // 跨平台訊息通道類
 │              
 └── /test //測試檔區域(Unit Test那些的，不會被包進安裝檔)
 │              
 └── pubspec.yaml //Flutter依賴跟版本號設定檔
```

### 跨平台訊息類 /flutter_integrate_module/lib/channel_util.dart

```dart
/// 'flutter_integrate_module/method' = 要連接的通道名稱(與原生端相同)
static const myMethodChannel = const MethodChannel('flutter_integrate_module/method');

/// 'flutterMethod' = 訊息的辨識ID(用來做分類或篩選)
static const testMethodName = 'flutterMethod'; 

/// 連接跨平台通道並綁定接收訊息時的回傳方法
static start({
    Future<dynamic> Function(dynamic)? onReceivedMethod,
    Future<String> Function(String)? onReceivedBasic,
  })

/// 建立持續型串流資料的接收通道給Flutter UI用
static Stream startStream()
```
