import 'package:collection/collection.dart';

import 'costs.dart';
import 'item.dart';
import 'packing_slip.dart';
import 'pricing_breakdown.dart';
import 'recipient.dart';
import 'retail_costs.dart';

class Result {
  int? id;
  String? externalId;
  int? store;
  String? status;
  dynamic error;
  int? errorCode;
  String? shipping;
  String? shippingServiceName;
  int? created;
  int? updated;
  Recipient? recipient;
  dynamic notes;
  List<dynamic>? incompleteItems;
  bool? isSample;
  bool? needsApproval;
  bool? notSynced;
  bool? hasDiscontinuedItems;
  bool? canChangeHold;
  Costs? costs;
  String? dashboardUrl;
  List<PricingBreakdown>? pricingBreakdown;
  List<Item>? items;
  List<dynamic>? brandingItems;
  List<dynamic>? shipments;
  PackingSlip? packingSlip;
  RetailCosts? retailCosts;
  dynamic gift;

  Result({
    this.id,
    this.externalId,
    this.store,
    this.status,
    this.error,
    this.errorCode,
    this.shipping,
    this.shippingServiceName,
    this.created,
    this.updated,
    this.recipient,
    this.notes,
    this.incompleteItems,
    this.isSample,
    this.needsApproval,
    this.notSynced,
    this.hasDiscontinuedItems,
    this.canChangeHold,
    this.costs,
    this.dashboardUrl,
    this.pricingBreakdown,
    this.items,
    this.brandingItems,
    this.shipments,
    this.packingSlip,
    this.retailCosts,
    this.gift,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as int?,
        externalId: json['external_id'] as String?,
        store: json['store'] as int?,
        status: json['status'] as String?,
        error: json['error'] as dynamic,
        errorCode: json['errorCode'] as int?,
        shipping: json['shipping'] as String?,
        shippingServiceName: json['shipping_service_name'] as String?,
        created: json['created'] as int?,
        updated: json['updated'] as int?,
        recipient: json['recipient'] == null
            ? null
            : Recipient.fromJson(json['recipient'] as Map<String, dynamic>),
        notes: json['notes'] as dynamic,
        incompleteItems: json['incomplete_items'] as List<dynamic>?,
        isSample: json['is_sample'] as bool?,
        needsApproval: json['needs_approval'] as bool?,
        notSynced: json['not_synced'] as bool?,
        hasDiscontinuedItems: json['has_discontinued_items'] as bool?,
        canChangeHold: json['can_change_hold'] as bool?,
        costs: json['costs'] == null
            ? null
            : Costs.fromJson(json['costs'] as Map<String, dynamic>),
        dashboardUrl: json['dashboard_url'] as String?,
        pricingBreakdown: (json['pricing_breakdown'] as List<dynamic>?)
            ?.map((e) => PricingBreakdown.fromJson(e as Map<String, dynamic>))
            .toList(),
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        brandingItems: json['branding_items'] as List<dynamic>?,
        shipments: json['shipments'] as List<dynamic>?,
        packingSlip: json['packing_slip'] == null
            ? null
            : PackingSlip.fromJson(
                json['packing_slip'] as Map<String, dynamic>),
        retailCosts: json['retail_costs'] == null
            ? null
            : RetailCosts.fromJson(
                json['retail_costs'] as Map<String, dynamic>),
        gift: json['gift'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'external_id': externalId,
        'store': store,
        'status': status,
        'error': error,
        'errorCode': errorCode,
        'shipping': shipping,
        'shipping_service_name': shippingServiceName,
        'created': created,
        'updated': updated,
        'recipient': recipient?.toJson(),
        'notes': notes,
        'incomplete_items': incompleteItems,
        'is_sample': isSample,
        'needs_approval': needsApproval,
        'not_synced': notSynced,
        'has_discontinued_items': hasDiscontinuedItems,
        'can_change_hold': canChangeHold,
        'costs': costs?.toJson(),
        'dashboard_url': dashboardUrl,
        'pricing_breakdown': pricingBreakdown?.map((e) => e.toJson()).toList(),
        'items': items?.map((e) => e.toJson()).toList(),
        'branding_items': brandingItems,
        'shipments': shipments,
        'packing_slip': packingSlip?.toJson(),
        'retail_costs': retailCosts?.toJson(),
        'gift': gift,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      externalId.hashCode ^
      store.hashCode ^
      status.hashCode ^
      error.hashCode ^
      errorCode.hashCode ^
      shipping.hashCode ^
      shippingServiceName.hashCode ^
      created.hashCode ^
      updated.hashCode ^
      recipient.hashCode ^
      notes.hashCode ^
      incompleteItems.hashCode ^
      isSample.hashCode ^
      needsApproval.hashCode ^
      notSynced.hashCode ^
      hasDiscontinuedItems.hashCode ^
      canChangeHold.hashCode ^
      costs.hashCode ^
      dashboardUrl.hashCode ^
      pricingBreakdown.hashCode ^
      items.hashCode ^
      brandingItems.hashCode ^
      shipments.hashCode ^
      packingSlip.hashCode ^
      retailCosts.hashCode ^
      gift.hashCode;
}
