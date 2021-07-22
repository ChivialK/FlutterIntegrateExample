package com.hcchiang.flutterintegrationtest.ui.flutter

interface IFlutterChannelListener{
    fun fromFlutterBasic(message: String): String
    fun fromFlutterMethod(message: String)
}

