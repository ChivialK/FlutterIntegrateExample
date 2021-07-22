package com.hcchiang.flutterintegrationtest.ui.flutter

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class FlutterIntegrateEventChannel(messenger: BinaryMessenger) : EventChannel.StreamHandler {

    private var eventChannel: EventChannel? = null

    private var eventSink: EventChannel.EventSink? = null

    private var listener: IFlutterChannelListener? = null

    init {
        try {
            eventChannel = EventChannel(messenger, EVENT_CHANNEL_NAME)
            resetHandler()
        } catch (e: Exception) {
            Log.w("AppEventChannel", "create channel has exception!!", e)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.i("AppEventChannel", "onListen arguments: $arguments")
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        Log.i("AppEventChannel", "onCancel arguments: $arguments")
    }

    fun resetHandler() {
        cancel()
        eventChannel?.setStreamHandler(this)
    }

    fun sink(msg: String) {
        eventSink?.success(msg)
    }

    fun cancel() {
        try {
            eventSink?.endOfStream()
            eventSink = null
        } catch (e: Exception) {
            Log.w("AppEventChannel", "cancel event channel has exception!!", e)
        }
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
        const val EVENT_CHANNEL_NAME = "flutter_integrate_module/event"

        var instance: FlutterIntegrateEventChannel? = null
            get() = if (field != null) field else throw  ExceptionInInitializerError()
            private set

        fun setup(messenger: BinaryMessenger) {
            instance = FlutterIntegrateEventChannel(messenger)
        }
    }
}