import 'package:json_annotation/json_annotation.dart';
import 'package:shopify_sheet/shopify_sheet.dart';

part 'shopify_sheet_completed_event.g.dart';

@JsonSerializable()
class ShopifySheetCompletedEvent extends ShopifySheetEvent {
  final OrderDetails orderDetails;

  ShopifySheetCompletedEvent({
    required this.orderDetails,
    super.type = ShopifySheetEventType.completed,
  });

  factory ShopifySheetCompletedEvent.fromJson(Map<String, dynamic> json) =>
      _$ShopifySheetCompletedEventFromJson(json);
  Map<String, dynamic> toJson() => _$ShopifySheetCompletedEventToJson(this);
}

// --- Order Details & Root Event ---

@JsonSerializable()
class OrderDetails {
  final Address? billingAddress;
  final CartInfo cart;
  final List<DeliveryInfo>? deliveries;
  final String? email;
  final String id;
  final List<PaymentMethod>? paymentMethods;
  final String? phone;

  OrderDetails({
    this.billingAddress,
    required this.cart,
    this.deliveries,
    this.email,
    required this.id,
    this.paymentMethods,
    this.phone,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}

// --- Price / Money ---
@JsonSerializable()
class Money {
  final double? amount;
  final String? currencyCode;

  Money({this.amount, this.currencyCode});

  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);
  Map<String, dynamic> toJson() => _$MoneyToJson(this);
}

@JsonSerializable()
class Price {
  final List<Discount>? discounts;
  final Money? shipping;
  final Money? subtotal;
  final Money? taxes;
  final Money? total;

  Price({this.discounts, this.shipping, this.subtotal, this.taxes, this.total});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

// --- Discount ---

@JsonSerializable()
class Discount {
  final Money? amount;
  final String? applicationType;
  final String? title;
  final double? value;
  final String? valueType;

  Discount({
    this.amount,
    this.applicationType,
    this.title,
    this.value,
    this.valueType,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

// --- Address ---

@JsonSerializable()
class Address {
  final String? address1;
  final String? address2;
  final String? city;
  final String? countryCode;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? phone;
  final String? postalCode;
  final String? referenceId;
  final String? zoneCode;

  Address({
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.firstName,
    this.lastName,
    this.name,
    this.phone,
    this.postalCode,
    this.referenceId,
    this.zoneCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

// --- Cart Info / Lines ---

@JsonSerializable()
class CartLineImage {
  final String? altText;
  final String lg;
  final String md;
  final String sm;

  CartLineImage({
    this.altText,
    required this.lg,
    required this.md,
    required this.sm,
  });

  factory CartLineImage.fromJson(Map<String, dynamic> json) =>
      _$CartLineImageFromJson(json);
  Map<String, dynamic> toJson() => _$CartLineImageToJson(this);
}

@JsonSerializable()
class CartLine {
  final List<Discount>? discounts;
  final CartLineImage? image;
  final String? merchandiseId;
  final Money price;
  final String? productId;
  final int quantity;
  final String title;

  CartLine({
    this.discounts,
    this.image,
    this.merchandiseId,
    required this.price,
    this.productId,
    required this.quantity,
    required this.title,
  });

  factory CartLine.fromJson(Map<String, dynamic> json) =>
      _$CartLineFromJson(json);
  Map<String, dynamic> toJson() => _$CartLineToJson(this);
}

@JsonSerializable()
class CartInfo {
  final List<CartLine> lines;
  final Price price;
  final String token;

  CartInfo({required this.lines, required this.price, required this.token});

  factory CartInfo.fromJson(Map<String, dynamic> json) =>
      _$CartInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CartInfoToJson(this);
}

// --- Delivery Info ---

@JsonSerializable()
class DeliveryDetails {
  final String? additionalInfo;
  final Address? location;
  final String? name;

  DeliveryDetails({this.additionalInfo, this.location, this.name});

  factory DeliveryDetails.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryDetailsToJson(this);
}

@JsonSerializable()
class DeliveryInfo {
  final DeliveryDetails details;
  final String method;

  DeliveryInfo({required this.details, required this.method});

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) =>
      _$DeliveryInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryInfoToJson(this);
}

// --- Payment Method ---

@JsonSerializable()
class PaymentMethod {
  final Map<String, String>? details;
  final String type;

  PaymentMethod({this.details, required this.type});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
