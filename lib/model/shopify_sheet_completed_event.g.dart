// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopify_sheet_completed_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopifySheetCompletedEvent _$ShopifySheetCompletedEventFromJson(
  Map<String, dynamic> json,
) => ShopifySheetCompletedEvent(
  orderDetails: OrderDetails.fromJson(
    json['orderDetails'] as Map<String, dynamic>,
  ),
  type:
      $enumDecodeNullable(_$ShopifySheetEventTypeEnumMap, json['type']) ??
      ShopifySheetEventType.completed,
);

Map<String, dynamic> _$ShopifySheetCompletedEventToJson(
  ShopifySheetCompletedEvent instance,
) => <String, dynamic>{
  'type': _$ShopifySheetEventTypeEnumMap[instance.type]!,
  'orderDetails': instance.orderDetails,
};

const _$ShopifySheetEventTypeEnumMap = {
  ShopifySheetEventType.completed: 'completed',
  ShopifySheetEventType.canceled: 'canceled',
  ShopifySheetEventType.failed: 'failed',
  ShopifySheetEventType.unknown: 'unknown',
  ShopifySheetEventType.pixelEvent: 'pixelEvent',
};

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
  billingAddress: json['billingAddress'] == null
      ? null
      : Address.fromJson(json['billingAddress'] as Map<String, dynamic>),
  cart: CartInfo.fromJson(json['cart'] as Map<String, dynamic>),
  deliveries: (json['deliveries'] as List<dynamic>?)
      ?.map((e) => DeliveryInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  email: json['email'] as String?,
  id: json['id'] as String,
  paymentMethods: (json['paymentMethods'] as List<dynamic>?)
      ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
      .toList(),
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      'billingAddress': instance.billingAddress,
      'cart': instance.cart,
      'deliveries': instance.deliveries,
      'email': instance.email,
      'id': instance.id,
      'paymentMethods': instance.paymentMethods,
      'phone': instance.phone,
    };

Money _$MoneyFromJson(Map<String, dynamic> json) => Money(
  amount: (json['amount'] as num?)?.toDouble(),
  currencyCode: json['currencyCode'] as String?,
);

Map<String, dynamic> _$MoneyToJson(Money instance) => <String, dynamic>{
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
};

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
  discounts: (json['discounts'] as List<dynamic>?)
      ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
      .toList(),
  shipping: json['shipping'] == null
      ? null
      : Money.fromJson(json['shipping'] as Map<String, dynamic>),
  subtotal: json['subtotal'] == null
      ? null
      : Money.fromJson(json['subtotal'] as Map<String, dynamic>),
  taxes: json['taxes'] == null
      ? null
      : Money.fromJson(json['taxes'] as Map<String, dynamic>),
  total: json['total'] == null
      ? null
      : Money.fromJson(json['total'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
  'discounts': instance.discounts,
  'shipping': instance.shipping,
  'subtotal': instance.subtotal,
  'taxes': instance.taxes,
  'total': instance.total,
};

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
  amount: json['amount'] == null
      ? null
      : Money.fromJson(json['amount'] as Map<String, dynamic>),
  applicationType: json['applicationType'] as String?,
  title: json['title'] as String?,
  value: (json['value'] as num?)?.toDouble(),
  valueType: json['valueType'] as String?,
);

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
  'amount': instance.amount,
  'applicationType': instance.applicationType,
  'title': instance.title,
  'value': instance.value,
  'valueType': instance.valueType,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  address1: json['address1'] as String?,
  address2: json['address2'] as String?,
  city: json['city'] as String?,
  countryCode: json['countryCode'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  postalCode: json['postalCode'] as String?,
  referenceId: json['referenceId'] as String?,
  zoneCode: json['zoneCode'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'address1': instance.address1,
  'address2': instance.address2,
  'city': instance.city,
  'countryCode': instance.countryCode,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'name': instance.name,
  'phone': instance.phone,
  'postalCode': instance.postalCode,
  'referenceId': instance.referenceId,
  'zoneCode': instance.zoneCode,
};

CartLineImage _$CartLineImageFromJson(Map<String, dynamic> json) =>
    CartLineImage(
      altText: json['altText'] as String?,
      lg: json['lg'] as String,
      md: json['md'] as String,
      sm: json['sm'] as String,
    );

Map<String, dynamic> _$CartLineImageToJson(CartLineImage instance) =>
    <String, dynamic>{
      'altText': instance.altText,
      'lg': instance.lg,
      'md': instance.md,
      'sm': instance.sm,
    };

CartLine _$CartLineFromJson(Map<String, dynamic> json) => CartLine(
  discounts: (json['discounts'] as List<dynamic>?)
      ?.map((e) => Discount.fromJson(e as Map<String, dynamic>))
      .toList(),
  image: json['image'] == null
      ? null
      : CartLineImage.fromJson(json['image'] as Map<String, dynamic>),
  merchandiseId: json['merchandiseId'] as String?,
  price: Money.fromJson(json['price'] as Map<String, dynamic>),
  productId: json['productId'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  title: json['title'] as String,
);

Map<String, dynamic> _$CartLineToJson(CartLine instance) => <String, dynamic>{
  'discounts': instance.discounts,
  'image': instance.image,
  'merchandiseId': instance.merchandiseId,
  'price': instance.price,
  'productId': instance.productId,
  'quantity': instance.quantity,
  'title': instance.title,
};

CartInfo _$CartInfoFromJson(Map<String, dynamic> json) => CartInfo(
  lines: (json['lines'] as List<dynamic>)
      .map((e) => CartLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  price: Price.fromJson(json['price'] as Map<String, dynamic>),
  token: json['token'] as String,
);

Map<String, dynamic> _$CartInfoToJson(CartInfo instance) => <String, dynamic>{
  'lines': instance.lines,
  'price': instance.price,
  'token': instance.token,
};

DeliveryDetails _$DeliveryDetailsFromJson(Map<String, dynamic> json) =>
    DeliveryDetails(
      additionalInfo: json['additionalInfo'] as String?,
      location: json['location'] == null
          ? null
          : Address.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DeliveryDetailsToJson(DeliveryDetails instance) =>
    <String, dynamic>{
      'additionalInfo': instance.additionalInfo,
      'location': instance.location,
      'name': instance.name,
    };

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
  details: DeliveryDetails.fromJson(json['details'] as Map<String, dynamic>),
  method: json['method'] as String,
);

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{'details': instance.details, 'method': instance.method};

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      details: (json['details'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      type: json['type'] as String,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{'details': instance.details, 'type': instance.type};
