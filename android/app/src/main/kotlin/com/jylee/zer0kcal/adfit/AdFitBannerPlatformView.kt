package com.jylee.seoul_event.adfit

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import com.kakao.adfit.ads.ba.BannerAdView
import io.flutter.plugin.platform.PlatformView
import com.kakao.adfit.ads.AdListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class AdFitBannerPlatformView(
    private val activity: Activity,
    adUnitId: String,
    messenger: BinaryMessenger,
    id: Int
) : PlatformView, EventChannel.StreamHandler {

    private val adView: BannerAdView
    private var eventSink: EventChannel.EventSink? = null

    init {
        // 이벤트 채널 생성
        EventChannel(messenger, "adfit-banner-events-$id").setStreamHandler(this)

        adView = BannerAdView(activity).apply {
            setClientId(adUnitId)
            setAdListener(object : AdListener {
                override fun onAdLoaded() {
                    eventSink?.success("loaded")
                }

                override fun onAdFailed(errorCode: Int) {
                    eventSink?.error("load_failed", "Ad failed with error $errorCode", null)
                }

                override fun onAdClicked() {
                    eventSink?.success("clicked")
                }
            })
            loadAd()
        }
    }

    override fun getView(): View = adView

    override fun dispose() {
        adView.destroy()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}