package com.hcchiang.flutterintegrationtest.ui.flutter

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec

class FlutterIntegrateBasicChannel(messenger: BinaryMessenger) : BasicMessageChannel.MessageHandler<Any> {

    private var basicChannel: BasicMessageChannel<Any>? = null

    private var listener: IFlutterChannelListener? = null

    init {
        try {
            basicChannel = BasicMessageChannel(messenger, BASIC_CHANNEL_NAME, StandardMessageCodec.INSTANCE)
            basicChannel?.setMessageHandler { message, reply -> onMessage(message, reply) }
        } catch (e: Exception) {
            Log.w("AppBasicChannel", "create channel has exception!!", e)
        }
    }

    override fun onMessage(message: Any?, reply: BasicMessageChannel.Reply<Any>) {
        Log.i("AppBasicChannel", "on message: $message")
        val msg = message?.toString() ?: return
        val replyMsg = listener?.fromFlutterBasic(msg)
        if (replyMsg.isNullOrEmpty()) return
        reply.reply(replyMsg)
    }

    fun send(msg: String, callback: BasicMessageChannel.Reply<Any>?) {
        if (callback != null)
            basicChannel?.send(msg, callback)
        else
            basicChannel?.send(msg)
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
        const val BASIC_CHANNEL_NAME = "flutter_integrate_module/basic"

        var instance: FlutterIntegrateBasicChannel? = null
            get() = if (field != null) field else throw  ExceptionInInitializerError()
            private set

        fun setup(messenger: BinaryMessenger) {
            instance = FlutterIntegrateBasicChannel(messenger)
        }
    }

}