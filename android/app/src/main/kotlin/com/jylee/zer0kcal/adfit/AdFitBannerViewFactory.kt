import android.app.Activity
import android.content.Context
import com.jylee.seoul_event.adfit.AdFitBannerPlatformView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AdFitBannerViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<String, Any>
        val adUnitId = params?.get("adUnitId") as? String ?: ""
        return AdFitBannerPlatformView(activity, adUnitId, messenger, viewId)
    }
}