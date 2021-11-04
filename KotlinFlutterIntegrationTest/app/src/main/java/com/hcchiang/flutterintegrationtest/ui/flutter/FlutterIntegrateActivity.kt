package com.hcchiang.flutterintegrationtest.ui.flutter

import android.content.Context
import android.content.Intent
import android.graphics.drawable.ColorDrawable
import android.widget.ImageView
import android.widget.Toast
import androidx.core.content.ContextCompat
import com.hcchiang.flutterintegrationtest.R
import io.flutter.app.FlutterActivityEvents
import io.flutter.embedding.android.DrawableSplashScreen
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class FlutterIntegrateActivity : FlutterFragmentActivity(), IFlutterChannelListener {

    override fun provideSplashScreen(): SplashScreen {
        // https://flutter.dev/docs/development/ui/advanced/splash-screen
        return DrawableSplashScreen(
            ColorDrawable(ContextCompat.getColor(this, R.color.color_primary)),
            ImageView.ScaleType.CENTER,
            0
        )
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onPause() {
        super.onPause()
        FlutterIntegrateMethodChannel.instance?.removeChannelListener()
        FlutterIntegrateBasicChannel.instance?.removeChannelListener()
    }

    /**
     * Event calls from flutter
     * @see [FlutterActivityEvents]
     */
    override fun onPostResume() {
        println("onPostResume()")
        super.onPostResume()

        // set interface [IFlutterChannelListener] for independent activity.
        FlutterIntegrateMethodChannel.instance?.setChannelListener(this)
        FlutterIntegrateBasicChannel.instance?.setChannelListener(this)
    }

    override fun onNewIntent(intent: Intent) {
        println("onNewIntent(): $intent")
        super.onNewIntent(intent)
    }

    override fun onBackPressed() {
        println("onBackPressed()")

        // send back press event to flutter
        FlutterIntegrateMethodChannel.instance?.send("back")
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        println(
            "onRequestPermissionsResult(): $requestCode " +
                "| permissions: $permissions | result: $grantResults"
        )
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
//        flutterFragment!!.onRequestPermissionsResult(
//            requestCode,
//            permissions,
//            grantResults
//        )
    }

    override fun onUserLeaveHint() {
        println("onUserLeaveHint()")
    }

    override fun onTrimMemory(level: Int) {
        println("onTrimMemory(): $level")
        super.onTrimMemory(level)
    }

    /**
     * Channel Callbacks [IFlutterChannelListener]
     */
    override fun fromFlutterMethod(message: String) {
        println("FlutterIntegrateActivity onFlutterMessage: $message")

        val msg = "method: $message"
        Toast.makeText(applicationContext, msg, Toast.LENGTH_SHORT).show()

        if (message == "exit") {
            try {
                finish()
            } catch (e: Exception) {
                println("close flutter activity has exception: $e")
            } finally {
                println("flutter activity should be closed.")
            }
        }
    }

    override fun fromFlutterBasic(message: String): String {
        println("FlutterIntegrateActivity fromFlutterBasic: $message")

        val msg = "basic: $message"
        Toast.makeText(applicationContext, msg, Toast.LENGTH_SHORT).show()
        return ""
    }

    companion object {
        private fun withNewEngine() = CustomNewEngineIntentBuilder()

        private fun withCachedEngine(engineName: String) =
            CustomCachedEngineIntentBuilder(engineName)

        fun start(context: Context, cacheEngineName: String? = null) {
            val intent =
                if (cacheEngineName != null)
                    withCachedEngine(cacheEngineName).build(context)
                else
                    withNewEngine().build(context)
            context.startActivity(intent)
        }
    }

    // Create New DartVM Engine
    class CustomNewEngineIntentBuilder :
        FlutterFragmentActivity.NewEngineIntentBuilder(FlutterIntegrateActivity::class.java)

    // Cached DartVM Engine will warm up in FlutterIntegrateApp.kt
    class CustomCachedEngineIntentBuilder(engineId: String) :
        CachedEngineIntentBuilder(FlutterIntegrateActivity::class.java, engineId)
}
