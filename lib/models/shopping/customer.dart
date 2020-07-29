import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/shopping/currency.dart';
import 'package:storeFlutter/models/shopping/customer-specialisation.dart';
import 'package:storeFlutter/models/shopping/customer-type.dart';
import 'package:storeFlutter/models/shopping/exchange-rate-type.dart';
import 'package:storeFlutter/models/shopping/incoterm.dart';
import 'package:storeFlutter/models/shopping/industry.dart';
import 'package:storeFlutter/models/shopping/payment-method.dart';
import 'package:storeFlutter/models/shopping/payment-term.dart';
import 'package:storeFlutter/models/shopping/port.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  int customerID;
  int companyId;
  String name;
  String code;
  String shortName;

  String contactPerson;
  String contactEmail;
  LocalDateTime onboardEmailDate;
  LocalDateTime onboardedDate;

  OnboardStatus onboardStatus;
  CustomerStatus customerStatus;
  int referenceCompanyID;

  Industry industry;
  Incoterm incoterm;
  PaymentTerm paymentTerm;
  PaymentMethod paymentMethod;
  String currencyCode;
  Currency currency;
  ExchangeRateType exchangeRateType;

  String billingAddress;
  String billingCountryCode;
  String billingCountryName;
  String billingPostcode;
  String billingCity;
  String billingState;

  String tradeType;
  String deliveryMode;
  String shippingAddress;
  String shippingCountryCode;
  String shippingPortCode;
  Port shippingPort;
  String shippingPostcode;
  String shippingCity;
  String shippingState;
  String nearestPortCountry;

//  showcaseProducts: CustomerShowcaseProduct[] = [];

  CustomerType customerType;
  CustomerSpecialisation customerSpecialisation;

  Customer(
      {this.customerID,
      this.companyId,
      this.name,
      this.code,
      this.shortName,
      this.contactPerson,
      this.contactEmail,
      this.onboardEmailDate,
      this.onboardedDate,
      this.onboardStatus,
      this.customerStatus,
      this.referenceCompanyID,
      this.industry,
      this.incoterm,
      this.paymentTerm,
      this.paymentMethod,
      this.currencyCode,
      this.currency,
      this.exchangeRateType,
      this.billingAddress,
      this.billingCountryCode,
      this.billingCountryName,
      this.billingPostcode,
      this.billingCity,
      this.billingState,
      this.tradeType,
      this.deliveryMode,
      this.shippingAddress,
      this.shippingCountryCode,
      this.shippingPortCode,
      this.shippingPort,
      this.shippingPostcode,
      this.shippingCity,
      this.shippingState,
      this.nearestPortCountry,
      this.customerType,
      this.customerSpecialisation});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

enum OnboardStatus { PENDING, ONBOARDED }

enum CustomerStatus { ACTIVE, INACTIVE }
