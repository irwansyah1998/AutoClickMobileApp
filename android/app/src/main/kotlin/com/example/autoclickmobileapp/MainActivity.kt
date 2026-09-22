package com.example.autoclickmobileapp

import com.example.autoclickmobileapp.bridge.NativeBridge
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private lateinit var nativeBridge: NativeBridge

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        nativeBridge = NativeBridge(this)
        nativeBridge.attach(flutterEngine)
    }
}
