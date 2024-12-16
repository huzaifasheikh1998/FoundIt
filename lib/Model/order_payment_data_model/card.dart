import 'package:collection/collection.dart';

import 'checks.dart';
import 'extended_authorization.dart';
import 'incremental_authorization.dart';
import 'multicapture.dart';
import 'network_token.dart';
import 'overcapture.dart';

class Card {
  int? amountAuthorized;
  String? brand;
  Checks? checks;
  String? country;
  int? expMonth;
  int? expYear;
  ExtendedAuthorization? extendedAuthorization;
  String? fingerprint;
  String? funding;
  IncrementalAuthorization? incrementalAuthorization;
  dynamic installments;
  String? last4;
  dynamic mandate;
  Multicapture? multicapture;
  String? network;
  NetworkToken? networkToken;
  Overcapture? overcapture;
  dynamic threeDSecure;
  dynamic wallet;

  Card({
    this.amountAuthorized,
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.extendedAuthorization,
    this.fingerprint,
    this.funding,
    this.incrementalAuthorization,
    this.installments,
    this.last4,
    this.mandate,
    this.multicapture,
    this.network,
    this.networkToken,
    this.overcapture,
    this.threeDSecure,
    this.wallet,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        amountAuthorized: json['amount_authorized'] as int?,
        brand: json['brand'] as String?,
        checks: json['checks'] == null
            ? null
            : Checks.fromJson(json['checks'] as Map<String, dynamic>),
        country: json['country'] as String?,
        expMonth: json['exp_month'] as int?,
        expYear: json['exp_year'] as int?,
        extendedAuthorization: json['extended_authorization'] == null
            ? null
            : ExtendedAuthorization.fromJson(
                json['extended_authorization'] as Map<String, dynamic>),
        fingerprint: json['fingerprint'] as String?,
        funding: json['funding'] as String?,
        incrementalAuthorization: json['incremental_authorization'] == null
            ? null
            : IncrementalAuthorization.fromJson(
                json['incremental_authorization'] as Map<String, dynamic>),
        installments: json['installments'] as dynamic,
        last4: json['last4'] as String?,
        mandate: json['mandate'] as dynamic,
        multicapture: json['multicapture'] == null
            ? null
            : Multicapture.fromJson(
                json['multicapture'] as Map<String, dynamic>),
        network: json['network'] as String?,
        networkToken: json['network_token'] == null
            ? null
            : NetworkToken.fromJson(
                json['network_token'] as Map<String, dynamic>),
        overcapture: json['overcapture'] == null
            ? null
            : Overcapture.fromJson(json['overcapture'] as Map<String, dynamic>),
        threeDSecure: json['three_d_secure'] as dynamic,
        wallet: json['wallet'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'amount_authorized': amountAuthorized,
        'brand': brand,
        'checks': checks?.toJson(),
        'country': country,
        'exp_month': expMonth,
        'exp_year': expYear,
        'extended_authorization': extendedAuthorization?.toJson(),
        'fingerprint': fingerprint,
        'funding': funding,
        'incremental_authorization': incrementalAuthorization?.toJson(),
        'installments': installments,
        'last4': last4,
        'mandate': mandate,
        'multicapture': multicapture?.toJson(),
        'network': network,
        'network_token': networkToken?.toJson(),
        'overcapture': overcapture?.toJson(),
        'three_d_secure': threeDSecure,
        'wallet': wallet,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Card) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      amountAuthorized.hashCode ^
      brand.hashCode ^
      checks.hashCode ^
      country.hashCode ^
      expMonth.hashCode ^
      expYear.hashCode ^
      extendedAuthorization.hashCode ^
      fingerprint.hashCode ^
      funding.hashCode ^
      incrementalAuthorization.hashCode ^
      installments.hashCode ^
      last4.hashCode ^
      mandate.hashCode ^
      multicapture.hashCode ^
      network.hashCode ^
      networkToken.hashCode ^
      overcapture.hashCode ^
      threeDSecure.hashCode ^
      wallet.hashCode;
}
