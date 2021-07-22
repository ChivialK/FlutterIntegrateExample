package com.hcchiang.flutterintegrationtest.ui.flutter

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class FlutterIntegrateMethodChannel(messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {

    private var methodChannel: MethodChannel? = null

    private var listener: IFlutterChannelListener? = null

    init {
        try {
            methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME).apply {
                setMethodCallHandler(this@FlutterIntegrateMethodChannel)
            }
        } catch (e: Exception) {
            Log.w("AppMethodChannel", "create channel has exception!!", e)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.i("AppMethodChannel", "method: ${call.method}, arg: ${call.arguments}")
        if (call.method == "flutterMethod") {
            val message = call.arguments?.toString()
            if (message.isNullOrEmpty()) return
            listener?.fromFlutterMethod(message)
        }
    }

    fun send(msg: String) {
        methodChannel?.invokeMethod(METHOD_CHANNEL_NAME, msg)
    }

    /**
     * Bind flutter message callback listener
     */
    fun setChannelListener(listener: IFlutterChannelListener) {
        this.listener = listener
    }

    fun removeChannelListener() {
        this.listener = null
    }

    companion object {
        const val METHOD_CHANNEL_NAME = "flutter_integrate_module/method"

        var instance: FlutterIntegrateMethodChannel? = null
            get() = if (field != null) field else throw  ExceptionInInitializerError()
            private set

        fun setup(messenger: BinaryMessenger) {
            instance = FlutterIntegrateMethodChannel(messenger)
        }
    }
}
