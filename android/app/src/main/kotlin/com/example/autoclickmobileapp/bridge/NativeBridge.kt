package com.example.autoclickmobileapp.bridge

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class NativeBridge(private val context: Context) {
    private val channelName = "autoclickmobileapp/native"
    private var channel: MethodChannel? = null

    fun attach(engine: FlutterEngine) {
        channel = MethodChannel(engine.dartExecutor.binaryMessenger, channelName)
        channel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "checkAccessibility" -> result.success(true)
                "checkOverlayPermission" -> result.success(false)
                "startClicker" -> result.success(true)
                "stopClicker" -> result.success(true)
                "pauseClicker" -> result.success(true)
                "resumeClicker" -> result.success(true)
                else -> result.notImplemented()
            }
        }
        Log.d("NativeBridge", "Method channel attached")
    }
}
