import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/image.dart';
import 'package:storeFlutter/models/shopping/category.dart';
import 'package:storeFlutter/models/shopping/characteristic.dart';
import 'package:storeFlutter/models/shopping/property-value.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/models/shopping/specification-value.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String name;
  String code;
  ProductType productType;

  String brand;
  String model;
  String description;
  String longDescription;
  String keySellingPoint;
  String videoUrl;
  LocalDate dateCreated;
  String productApplication;
  String howItWork;
  String productHandling;
  List<int> keyContactPersons; // account ID
  DeliveryDateOption deliveryDateOption = DeliveryDateOption.DEFAULT;

  List<int> supplyLocations;
  List<Image> images;
  List<PropertyValue> propertyValues;
  List<Characteristic> characteristics;
  List<SpecificationValue> specificationValues;

  List<Sku> variantSkus;
  Status status;
  String supplierUuid;
  int companyId;
  Company sellerCompany;
  CompanyProfile sellerCompanyProfile;

  double consumerPrice;
  String consumerPriceUom;
  String consumerPriceCurrency;

  int skuSize;
  Category category;
  String uomCode;
  bool isContainerize;

  String keywords;
  int daysToShip;

  double weight;
  double height;
  double width;
  double length;

  String warrantyType;

  Product(
      this.id,
      this.name,
      this.code,
      this.productType,
      this.brand,
      this.model,
      this.description,
      this.longDescription,
      this.keySellingPoint,
      this.videoUrl,
      this.dateCreated,
      this.productApplication,
      this.howItWork,
      this.productHandling,
      this.keyContactPersons,
      this.deliveryDateOption,
      this.supplyLocations,
      this.images,
      this.propertyValues,
      this.characteristics,
      this.specificationValues,
      this.variantSkus,
      this.status,
      this.supplierUuid,
      this.companyId,
      this.sellerCompany,
      this.sellerCompanyProfile,
      this.consumerPrice,
      this.consumerPriceUom,
      this.consumerPriceCurrency,
      this.skuSize,
      this.category,
      this.uomCode,
      this.isContainerize,
      this.keywords,
      this.daysToShip,
      this.weight,
      this.height,
      this.width,
      this.length,
      this.warrantyType);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

enum ProductType { SKU, MTO }

enum DeliveryDateOption { DEFAULT, SPECIFIC, RANGE, WEEK, MONTH }

enum Status { ACTIVE, DRAFT, INACTIVE }
