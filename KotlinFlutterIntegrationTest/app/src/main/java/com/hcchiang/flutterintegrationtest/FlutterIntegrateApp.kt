package com.hcchiang.flutterintegrationtest

import android.app.Application
import com.hcchiang.flutterintegrationtest.ui.flutter.FlutterIntegrateBasicChannel
import com.hcchiang.flutterintegrationtest.ui.flutter.FlutterIntegrateEventChannel
import com.hcchiang.flutterintegrationtest.ui.flutter.FlutterIntegrateMethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

/*
 * Warm up Flutter Engine on app start.
 * Don't forget to declare the name in AndroidManifest under application tag.
 */
class FlutterIntegrateApp: Application() {
    companion object {
        const val FLUTTER_ENGINE_ID = "newIntegrateEngine"
    }

    override fun onCreate() {
        super.onCreate()
        // Instantiate a FlutterEngine.
        val flutterEngine = FlutterEngine(this)

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
            .getInstance()
            .put(FLUTTER_ENGINE_ID, flutterEngine)

        // Setup Channels between native and flutter
        FlutterIntegrateMethodChannel.setup(flutterEngine.dartExecutor.binaryMessenger)
        FlutterIntegrateBasicChannel.setup(flutterEngine.dartExecutor.binaryMessenger)
        FlutterIntegrateEventChannel.setup(flutterEngine.dartExecutor.binaryMessenger)
    }
}
