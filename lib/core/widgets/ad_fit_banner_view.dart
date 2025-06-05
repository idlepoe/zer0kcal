import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdFitBannerView extends StatefulWidget {
  final String adUnitId;
  final double height;
  final ValueChanged<String>? onEvent; // "loaded", "clicked", "error" 등

  const AdFitBannerView({
    super.key,
    required this.adUnitId,
    this.height = 100, // 기본 배너 높이 (단위: dp)
    this.onEvent,
  });

  @override
  State<AdFitBannerView> createState() => _AdFitBannerViewState();
}

class _AdFitBannerViewState extends State<AdFitBannerView> {
  EventChannel? _eventChannel;

  @override
  void initState() {
    super.initState();
    // 이벤트 채널은 viewId 생성 이후에 연결됨 (onPlatformViewCreated)
  }

  void _onPlatformViewCreated(int viewId) {
    _eventChannel = EventChannel('adfit-banner-events-$viewId');

    _eventChannel!.receiveBroadcastStream().listen((event) {
      debugPrint('[AdFitBanner] event: $event');
      widget.onEvent?.call(event.toString());
    }, onError: (error) {
      debugPrint('[AdFitBanner] error: $error');
      widget.onEvent?.call('error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AndroidView(
        viewType: 'adfit-banner-view',
        creationParams: {
          'adUnitId': widget.adUnitId,
        },
        onPlatformViewCreated: _onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
