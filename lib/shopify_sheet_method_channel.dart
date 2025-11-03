import 'package:flutter/services.dart';
import 'package:shopify_sheet/model/shopify_sheet_color_scheme.dart';

import 'shopify_sheet_platform_interface.dart';

class MethodChannelShopifySheet extends ShopifySheetPlatform {
  final methodChannel = const MethodChannel('shopify_sheet');
  final eventChannel = const EventChannel('shopify_sheet_events');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<void> launchCheckout(
    String checkoutUrl, {
    ShopifySheetColorScheme colorScheme = ShopifySheetColorScheme.automatic,
  }) async {
    await methodChannel.invokeMethod('launchCheckout', {
      'checkoutUrl': checkoutUrl,
      'colorScheme': colorScheme.name,
    });
  }

  @override
  Stream<Map<String, dynamic>> get checkoutEvents {
    return eventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event);
    });
  }

  @override
  Future<void> closeCheckout() => methodChannel.invokeMethod('closeCheckout');
}
