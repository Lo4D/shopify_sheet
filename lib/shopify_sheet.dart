import 'package:shopify_sheet/model/shopify_sheet_color_scheme.dart';
import 'package:shopify_sheet/model/shopify_sheet_completed_event.dart';
import 'package:shopify_sheet/shopify_sheet_platform_interface.dart';
import 'package:shopify_sheet/utils/standard_codec_map_converter.dart';

/// Event data for Shopify Checkout
class ShopifySheetEvent {
  final ShopifySheetEventType type;
  final String? error;
  final Map<dynamic, dynamic>? data;

  ShopifySheetEvent({required this.type, this.error, this.data});

  /// Factory to parse event data from native
  factory ShopifySheetEvent.fromNative(Map<String, dynamic> data) {
    final eventType = data['event'];
    final error = data['error'] as String?;
    final eventData = data['data'] as Map<Object?, Object?>?;

    final Map<String, dynamic>? eventDataJsonMap;
    if (eventData != null) {
      final converter = StandardCodecMapConverter();
      eventDataJsonMap = converter.fromJson(eventData);
    } else {
      eventDataJsonMap = null;
    }

    switch (eventType) {
      case 'completed':
        if (eventDataJsonMap == null) {
          return ShopifySheetEvent(
            type: ShopifySheetEventType.completed,
            error: error,
            data: eventData,
          );
        }
        return ShopifySheetCompletedEvent.fromJson(eventDataJsonMap);
      case 'canceled':
        return ShopifySheetEvent(
          type: ShopifySheetEventType.canceled,
          error: error,
        );
      case 'failed':
        return ShopifySheetEvent(
          type: ShopifySheetEventType.failed,
          error: error,
        );
      case 'pixel_event':
        return ShopifySheetEvent(
          type: ShopifySheetEventType.pixelEvent,
          data: eventData,
        );
      default:
        return ShopifySheetEvent(
          type: ShopifySheetEventType.unknown,
          error: error,
        );
    }
  }
}

/// Enum for Shopify Checkout event types
enum ShopifySheetEventType { completed, canceled, failed, unknown, pixelEvent }

class ShopifySheet {
  Future<String?> getPlatformVersion() {
    return ShopifySheetPlatform.instance.getPlatformVersion();
  }

  Future<void> launchCheckout(
    String checkoutUrl, {
    ShopifySheetColorScheme colorScheme = ShopifySheetColorScheme.automatic,
  }) {
    return ShopifySheetPlatform.instance.launchCheckout(
      checkoutUrl,
      colorScheme: colorScheme,
    );
  }

  /// Listen for checkout events
  Stream<ShopifySheetEvent> get checkoutEvents {
    return ShopifySheetPlatform.instance.checkoutEvents.map((event) {
      return ShopifySheetEvent.fromNative(event);
    });
  }

  Future<void> closeCheckout() {
    return ShopifySheetPlatform.instance.closeCheckout();
  }
}
