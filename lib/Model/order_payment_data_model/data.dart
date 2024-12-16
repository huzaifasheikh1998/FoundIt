import 'package:collection/collection.dart';

import 'billing_details.dart';
import 'outcome.dart';
import 'payment_method_details.dart';
import 'source.dart';

class Data {
  String? id;
  String? object;
  int? amount;
  int? amountCaptured;
  int? amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String? balanceTransaction;
  BillingDetails? billingDetails;
  String? calculatedStatementDescriptor;
  bool? captured;
  int? created;
  String? currency;
  dynamic customer;
  String? description;
  dynamic destination;
  dynamic dispute;
  bool? disputed;
  dynamic failureBalanceTransaction;
  dynamic failureCode;
  dynamic failureMessage;
  List<dynamic>? fraudDetails;
  dynamic invoice;
  bool? livemode;
  List<dynamic>? metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome? outcome;
  bool? paid;
  dynamic paymentIntent;
  String? paymentMethod;
  PaymentMethodDetails? paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String? receiptUrl;
  bool? refunded;
  dynamic review;
  dynamic shipping;
  Source? source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  dynamic transferGroup;

  Data({
    this.id,
    this.object,
    this.amount,
    this.amountCaptured,
    this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction,
    this.billingDetails,
    this.calculatedStatementDescriptor,
    this.captured,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    this.disputed,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    this.fraudDetails,
    this.invoice,
    this.livemode,
    this.metadata,
    this.onBehalfOf,
    this.order,
    this.outcome,
    this.paid,
    this.paymentIntent,
    this.paymentMethod,
    this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl,
    this.refunded,
    this.review,
    this.shipping,
    this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as String?,
        object: json['object'] as String?,
        amount: json['amount'] as int?,
        amountCaptured: json['amount_captured'] as int?,
        amountRefunded: json['amount_refunded'] as int?,
        application: json['application'] as dynamic,
        applicationFee: json['application_fee'] as dynamic,
        applicationFeeAmount: json['application_fee_amount'] as dynamic,
        balanceTransaction: json['balance_transaction'] as String?,
        billingDetails: json['billing_details'] == null
            ? null
            : BillingDetails.fromJson(
                json['billing_details'] as Map<String, dynamic>),
        calculatedStatementDescriptor:
            json['calculated_statement_descriptor'] as String?,
        captured: json['captured'] as bool?,
        created: json['created'] as int?,
        currency: json['currency'] as String?,
        customer: json['customer'] as dynamic,
        description: json['description'] as String?,
        destination: json['destination'] as dynamic,
        dispute: json['dispute'] as dynamic,
        disputed: json['disputed'] as bool?,
        failureBalanceTransaction:
            json['failure_balance_transaction'] as dynamic,
        failureCode: json['failure_code'] as dynamic,
        failureMessage: json['failure_message'] as dynamic,
        fraudDetails: json['fraud_details'] as List<dynamic>?,
        invoice: json['invoice'] as dynamic,
        livemode: json['livemode'] as bool?,
        metadata: json['metadata'] as List<dynamic>?,
        onBehalfOf: json['on_behalf_of'] as dynamic,
        order: json['order'] as dynamic,
        outcome: json['outcome'] == null
            ? null
            : Outcome.fromJson(json['outcome'] as Map<String, dynamic>),
        paid: json['paid'] as bool?,
        paymentIntent: json['payment_intent'] as dynamic,
        paymentMethod: json['payment_method'] as String?,
        paymentMethodDetails: json['payment_method_details'] == null
            ? null
            : PaymentMethodDetails.fromJson(
                json['payment_method_details'] as Map<String, dynamic>),
        receiptEmail: json['receipt_email'] as dynamic,
        receiptNumber: json['receipt_number'] as dynamic,
        receiptUrl: json['receipt_url'] as String?,
        refunded: json['refunded'] as bool?,
        review: json['review'] as dynamic,
        shipping: json['shipping'] as dynamic,
        source: json['source'] == null
            ? null
            : Source.fromJson(json['source'] as Map<String, dynamic>),
        sourceTransfer: json['source_transfer'] as dynamic,
        statementDescriptor: json['statement_descriptor'] as dynamic,
        statementDescriptorSuffix:
            json['statement_descriptor_suffix'] as dynamic,
        status: json['status'] as String?,
        transferData: json['transfer_data'] as dynamic,
        transferGroup: json['transfer_group'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'amount': amount,
        'amount_captured': amountCaptured,
        'amount_refunded': amountRefunded,
        'application': application,
        'application_fee': applicationFee,
        'application_fee_amount': applicationFeeAmount,
        'balance_transaction': balanceTransaction,
        'billing_details': billingDetails?.toJson(),
        'calculated_statement_descriptor': calculatedStatementDescriptor,
        'captured': captured,
        'created': created,
        'currency': currency,
        'customer': customer,
        'description': description,
        'destination': destination,
        'dispute': dispute,
        'disputed': disputed,
        'failure_balance_transaction': failureBalanceTransaction,
        'failure_code': failureCode,
        'failure_message': failureMessage,
        'fraud_details': fraudDetails,
        'invoice': invoice,
        'livemode': livemode,
        'metadata': metadata,
        'on_behalf_of': onBehalfOf,
        'order': order,
        'outcome': outcome?.toJson(),
        'paid': paid,
        'payment_intent': paymentIntent,
        'payment_method': paymentMethod,
        'payment_method_details': paymentMethodDetails?.toJson(),
        'receipt_email': receiptEmail,
        'receipt_number': receiptNumber,
        'receipt_url': receiptUrl,
        'refunded': refunded,
        'review': review,
        'shipping': shipping,
        'source': source?.toJson(),
        'source_transfer': sourceTransfer,
        'statement_descriptor': statementDescriptor,
        'statement_descriptor_suffix': statementDescriptorSuffix,
        'status': status,
        'transfer_data': transferData,
        'transfer_group': transferGroup,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      object.hashCode ^
      amount.hashCode ^
      amountCaptured.hashCode ^
      amountRefunded.hashCode ^
      application.hashCode ^
      applicationFee.hashCode ^
      applicationFeeAmount.hashCode ^
      balanceTransaction.hashCode ^
      billingDetails.hashCode ^
      calculatedStatementDescriptor.hashCode ^
      captured.hashCode ^
      created.hashCode ^
      currency.hashCode ^
      customer.hashCode ^
      description.hashCode ^
      destination.hashCode ^
      dispute.hashCode ^
      disputed.hashCode ^
      failureBalanceTransaction.hashCode ^
      failureCode.hashCode ^
      failureMessage.hashCode ^
      fraudDetails.hashCode ^
      invoice.hashCode ^
      livemode.hashCode ^
      metadata.hashCode ^
      onBehalfOf.hashCode ^
      order.hashCode ^
      outcome.hashCode ^
      paid.hashCode ^
      paymentIntent.hashCode ^
      paymentMethod.hashCode ^
      paymentMethodDetails.hashCode ^
      receiptEmail.hashCode ^
      receiptNumber.hashCode ^
      receiptUrl.hashCode ^
      refunded.hashCode ^
      review.hashCode ^
      shipping.hashCode ^
      source.hashCode ^
      sourceTransfer.hashCode ^
      statementDescriptor.hashCode ^
      statementDescriptorSuffix.hashCode ^
      status.hashCode ^
      transferData.hashCode ^
      transferGroup.hashCode;
}
