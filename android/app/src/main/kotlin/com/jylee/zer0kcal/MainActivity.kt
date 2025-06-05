package com.jylee.zer0kcal

import AdFitBannerViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine.platformViewsController.registry.registerViewFactory(
            "adfit-banner-view",
            AdFitBannerViewFactory(this, flutterEngine.dartExecutor.binaryMessenger)
        )
    }
}