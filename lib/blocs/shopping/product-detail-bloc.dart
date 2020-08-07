import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-variant.dart';
import 'package:storeFlutter/datasource/annual-revenue-data-source.dart';
import 'package:storeFlutter/datasource/business-type-data-source.dart';
import 'package:storeFlutter/datasource/total-employee-data-source.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/shopping/consumer-product-list-price.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-param.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-response.dart';
import 'package:storeFlutter/models/shopping/minimum-order-quantity.dart';
import 'package:storeFlutter/models/shopping/product-stock-quantity.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/quote-item.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/models/shopping/variant-type-value.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/services/company-service.dart';
import 'package:storeFlutter/services/consumer-product-list-price-service.dart';
import 'package:storeFlutter/services/minimum-order-quantity-service.dart';
import 'package:storeFlutter/services/product-stock-quantity-service.dart';
import 'package:storeFlutter/services/sales-cart-service.dart';
import 'package:storeFlutter/services/shipment-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

// bloc
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final Product product;
  final BuildContext buildContext;
  SalesQuotation salesQuotation;
  QuoteItem quoteItem;

  CompanyProfile sellerCompanyProfile;
  Company sellerCompany;
  Location userAddress;
  List<EasyParcelResponse> shipment;

  final CompanyService _companyService = GetIt.I<CompanyService>();
  final CompanyProfileService _companyProfileService =
      GetIt.I<CompanyProfileService>();
  final ShipmentService _shipmentService = GetIt.I<ShipmentService>();
  final StorageService _storageService = GetIt.I<StorageService>();
  final MinimumOrderQuantityService _minimumOrderQuantityService =
      GetIt.I<MinimumOrderQuantityService>();
  final ProductStockQuantityService _productStockQuantityService =
      GetIt.I<ProductStockQuantityService>();
  final ConsumerProductListPriceService _consumerProductListPriceService =
      GetIt.I<ConsumerProductListPriceService>();
  final SalesCartService _salesCartService = GetIt.I<SalesCartService>();

  BusinessTypeDataSource _businessTypeDataSource =
      GetIt.I<BusinessTypeDataSource>();
  List<LabelValue> businessTypeLvs;

  TotalEmployeeDataSource _totalEmployeeDataSource =
      GetIt.I<TotalEmployeeDataSource>();
  List<LabelValue> totalEmployeeLvs;

  AnnualRevenueDataSource _annualRevenueDataSource =
      GetIt.I<AnnualRevenueDataSource>();
  List<LabelValue> annualRevenueLvs;

  List<VariantOption> variantOptions;
  List<Sku> variantSkus;

  // to save into sales quotation
  Sku selectedSku;
//  double quantity = 1;
//  double invoicePrice;
//  String currencyCode;
//  String uomCode;

  ProductDetailBloc({@required this.product, @required this.buildContext})
      : super(ProductDetailInitial()) {
    sellerCompany = this.product.sellerCompany;
    sellerCompanyProfile = this.product.sellerCompanyProfile;

    initSalesQuotation();

    add(ProductDetailLoad());
  }

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is ProductDetailLoad) {
      yield ProductDetailLoadInProgress();

      // reload company, company profile cause it might be outdated
      sellerCompany = await _companyService.getCompany(product.companyId);
      sellerCompanyProfile =
          await _companyProfileService.findByCompany(product.companyId);

      // get user's location
      CompanyProfile userProfile = await _companyProfileService
          .findByCompany(_storageService.loginUser.companyId);
      if (userProfile != null &&
          userProfile.locations != null &&
          userProfile.locations.length > 0) {
        userAddress = userProfile.locations
            .where((element) => element.defaultShipping == true)
            .toList()[0];
      }

      // get shipment
      shipment = await _shipmentService.getEasyParcel(new EasyParcelParam(
          senderPostcode: sellerCompany.postcode,
          senderCountry: sellerCompany.country,
          senderState: sellerCompany.state,
          receiverCountry:
              userAddress == null || userAddress.countryCode == null
                  ? "MY"
                  : userAddress.countryCode,
          receiverPostcode: userAddress == null || userAddress.postcode == null
              ? "45000"
              : userAddress.postcode,
          receiverState: userAddress == null || userAddress.state == null
              ? "Selangor"
              : userAddress.state,
          weight: product.weight,
          height: product.height,
          width: product.width,
          length: product.length));

      // some other data source to resolve?
      businessTypeLvs =
          await _businessTypeDataSource.getDataSource(buildContext);
      totalEmployeeLvs =
          await _totalEmployeeDataSource.getDataSource(buildContext);
      annualRevenueLvs =
          await _annualRevenueDataSource.getDataSource(buildContext);

      variantOptions = await buildVariantOptions();
      variantSkus = product.variantSkus;

      allVariantSelected();

//      resetBlocVariables();
      yield ProductDetailLoadComplete();
    } else if (event is ProductDetailChangeQuantity) {
      yield ProductDetailPriceUpdateInProgress();

      // TODO set quantity
      quoteItem.quantity = event.quantity.toDouble();

      yield ProductDetailPriceUpdateComplete();
    } else if (event is ProductDetailVariantSelection) {
      if (event.value != null) {
        onVariantOptionClicked(event.variantOption, event.value);
      }

      yield ProductDetailPriceUpdateInProgress();

      yield* refreshPriceAndQuantity();
    } else if (event is ProductDetailAddToCart) {
      yield ProductDetailAddToCartInProgress();

      // TODO add to cart

      yield ProductDetailAddToCartComplete();

      // TODO triger sales cart bloc to refresh...
    } else if (event is ProductDetailSelectAddress) {
      CompanyProfile userProfile = await _companyProfileService
          .findByCompany(_storageService.loginUser.companyId);
      userAddress = userProfile.locations
          .where((element) => element.id == event.id)
          .toList()[0];
      yield ProductDetailSelectAddressComplete(userAddress);
    }
  }

  void resetBlocVariables() {
    this.selectedSku = null;
//    this.variantOptions = null;
//    this.variantSkus = null;
  }

  Stream<ProductDetailState> refreshPriceAndQuantity() async* {
    bool priceError = false;
    bool stockError = false;

    if (selectedSku == null) {
      print("no sku");
      yield ProductDetailPriceUpdateFailed(noSkuError: true);
      return;
    }

    // TODO need to handle here
    String countryCode = "MY";

    if (userAddress != null) {
      countryCode = userAddress.countryCode;
    }
    ConsumerProductListPrice price = await _consumerProductListPriceService
        .getPrice(selectedSku.productSkuID, product.companyId, countryCode);

    if (price != null) {
      quoteItem.invoicePrice = price.price;
      quoteItem.currencyCode = price.currency.code;
      quoteItem.uomCode = price.uom.code;
    } else {
      quoteItem.invoicePrice = 0;
      priceError = true;
    }

    MinimumOrderQuantity minQty = await _minimumOrderQuantityService
        .findMinimumOrder(selectedSku.productSkuID, product.companyId);

    if (minQty != null) {
      quoteItem.minOrderQty = minQty.minQuantity;
    } else {
      quoteItem.minOrderQty = 1;
    }

    if (quoteItem.quantity == null ||
        quoteItem.quantity < quoteItem.minOrderQty) {
      quoteItem.quantity = quoteItem.minOrderQty;
    }

    ProductStockQuantity stock = await _productStockQuantityService.getStock(
        selectedSku.productSkuID, product.companyId, countryCode);

    if (stock != null) {
      quoteItem.maxOrderQty = stock.stock;
    } else {
      quoteItem.maxOrderQty = 0;
    }

    if (quoteItem.maxOrderQty == 0) {
      stockError = true;
    }

    if (priceError || stockError) {
      yield ProductDetailPriceUpdateFailed(
          priceError: priceError, stockError: stockError);
    } else {
      yield ProductDetailPriceUpdateComplete();
    }
  }

  void onVariantOptionClicked(VariantOption clickedOption, String value) {
    print("calling onVariantOptionClicked $variantSkus");
    if (variantSkus == null) {
      return null;
    }
    List<VariantOption> tempList;
    VariantOption selectedOption = variantOptions.firstWhere(
        (opt) => opt.variantType.code == clickedOption.variantType.code);
    selectedOption.selectedValue = value;
    variantOptions.forEach((option) {
      if (option.parentOption != null &&
          option.parentOption.variantType.code ==
              selectedOption.variantType.code) {
        option.labels = [];
        option.values = [];
        option.selectedValue = null;
        final parentValue = selectedOption.selectedValue;
        variantSkus.forEach((sku) {
          int index = 0;
          sku.variantValues.forEach((value) {
            if (value.variantType.code == option.variantType.code) {
              if (index > 0) {
                final parentVariant = sku.variantValues[index - 1];
                VariantTypeValue temp;
                temp = parentVariant.variantType.variantTypeValues.firstWhere(
                    (finder) => finder.id.toString() == parentVariant.value,
                    orElse: () => null);
                if (temp == null && !(parentVariant.value is int)) {
                  temp = VariantTypeValue(
                      0, parentVariant.label, parentVariant.value, 0);
                }
                if (temp != null && temp.value == parentValue) {
                  VariantTypeValue tempValue;
                  tempValue = value.variantType.variantTypeValues.firstWhere(
                      (finder) => finder.id.toString() == value.value,
                      orElse: () => null);
                  if (tempValue == null && !(value.value is int)) {
                    tempValue =
                        VariantTypeValue(0, value.label, value.value, 0);
                  }
                  if (tempValue != null &&
                      !option.values.contains(tempValue.value)) {
                    option.values.add(tempValue.value);
                    option.labels.add(value.label);
                  }
                  if (option.selectedValue == null) {
                    option.selectedValue = tempValue.value;
                  }
                }
              }
            }

            index++;
          });
        });
        selectedOption = option;
      }
    });

    allVariantSelected();
//    return variantOptions;
  }

  void allVariantSelected() {
    print(" calling all variant selected");
    bool allOptionsSelected = true;
    final variantValueMap = new Map<String, String>();

    variantOptions.forEach((option) {
      if (option.selectedValue == null || option.selectedValue == '') {
        allOptionsSelected = false;
        return;
      }
      variantValueMap[option.variantType.code] = option.selectedValue;
    });

    if (allOptionsSelected) {
      variantSkus.forEach((sku) {
        bool allVariantsMatched = true;
        sku.variantValues.forEach((variant) {
          final selectedValue = variantValueMap[variant.variantType.code];
          VariantTypeValue temp;
          temp = variant.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == variant.value,
              orElse: () => null);
          if (temp == null && !(variant.value is int)) {
            temp = VariantTypeValue(0, variant.label, variant.value, 0);
          }
          if (temp != null && (selectedValue != temp.value)) {
            allVariantsMatched = false;
            return;
          }
        });

        if (allVariantsMatched) {
          this.selectedSku = sku;
          print(this.selectedSku);
        }
      });
    }
  }

  initSalesQuotation() {
    salesQuotation = SalesQuotation();
    quoteItem = QuoteItem();
    quoteItem.quantity = 1;
  }

  populateSalesQuotation() {
//    SalesQuotation quotation = new SalesQuotation();
    // TODO to set some defaul value

//    this.salesQuotation.requestorAccount = this.currentUser;
//    this.salesQuotation.requestorCompany = this.currentCompany;
//    const company = this.storageService.getLoginCompany();
//    this.salesQuotation.buyerCompanyId = company.id;
//    this.salesQuotation.sellerCompanyId = this.product.companyId; // stamp seller id here for grouping

//    QuoteItem quoteItem = new QuoteItem();
//    this.salesQuotation.quoteItems[0] = quoteItem;
//    quoteItem.itemNumber = "1";
//    quoteItem.product = this.product;
//    quoteItem.sku = this.selectedSku;
//    quoteItem.quantity = this.quantity;
//    quoteItem.invoicePrice = this.listPrice;
//    quoteItem.currencyCode = this.currency;
//    quoteItem.checked = true;
//    if (this.listPriceObj) {
//      quoteItem.uomCode = this.listPriceObj.uom.code;
//    }
//    if (this.selectedSku && this.selectedSku.skuSalesUnit) {
//      quoteItem.product.uomCode = this.selectedSku.skuSalesUnit.code;
//    }
//
//    if (this.salesQuotation.storeShippingOption) {
//      this.salesQuotation.storeShippingOption.shippingAddress = this.deliveryLocation;
//    } else {
//      let storeShippingOption = new StoreShippingOption();
//      storeShippingOption.shippingAddress = this.deliveryLocation;
//      this.salesQuotation.storeShippingOption = storeShippingOption;
//    }
  }

  Future<List<VariantOption>> buildVariantOptions() async {
    // TODO copy from angular product-variant.component.ts?
//    int index = 0;

    List<VariantOption> variantOptions = [];
    List<Sku> variantSkus = product.variantSkus;
    for (var i = 0;
        i < product.category.variantFamily.variantTypes.length;
        i++) {
      VariantType type = product.category.variantFamily.variantTypes[i];

      var option = VariantOption();
      if (i > 0) {
        option.parentOption = variantOptions[i - 1];
      }

//      VariantType type = await _variantTypeService.get(temp.id);

      option.variantType = type;

      variantSkus.forEach((sku) {
        if (option.parentOption == null) {
          final variantValue = sku.variantValues[i];
          VariantTypeValue temp = variantValue.variantType.variantTypeValues
              .firstWhere((vv) => vv.id.toString() == variantValue.value,
                  orElse: () => null);
          if (temp == null && !(variantValue.value is int)) {
            temp =
                VariantTypeValue(0, variantValue.label, variantValue.value, 0);
          }
          if (temp != null && !option.values.contains(temp.value)) {
            option.values.add(temp.value);
            if (variantValue.label != null) {
              option.labels.add(variantValue.label);
            } else {
              if (variantValue.variantType != null &&
                  variantValue.variantType.variantTypeValues != null) {
                variantValue.variantType.variantTypeValues.forEach((v) {
                  if (variantValue.value == v.value.toString()) {
                    option.labels.add(v.name);
                  }
                });
              }
            }
          }
        } else {
          final parentValue = sku.variantValues[i - 1];
          final variantValue = sku.variantValues[i];

          VariantTypeValue tempParent;
          tempParent = parentValue.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == parentValue.value,
              orElse: () => null);
          if (tempParent == null && !(parentValue.value is int)) {
            tempParent =
                VariantTypeValue(0, parentValue.label, parentValue.value, 0);
          }
          VariantTypeValue temp;
          temp = variantValue.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == variantValue.value,
              orElse: () => null);
          if (temp == null && !(variantValue.value is int)) {
            temp =
                VariantTypeValue(0, variantValue.label, variantValue.value, 0);
          }

          //if parent selected
          if (option.parentOption.selectedValue != null) {
            if (tempParent.value == option.parentOption.selectedValue &&
                !option.values.contains(temp.value)) {
              option.values.add(temp.value);
              if (variantValue.label != null) {
                option.labels.add(variantValue.label);
              } else {
                if (variantValue.variantType != null &&
                    variantValue.variantType.variantTypeValues != null) {
                  variantValue.variantType.variantTypeValues.forEach((v) {
                    if (variantValue.value.toString() == v.value) {
                      option.labels.add(v.name);
                    }
                  });
                }
                // option.labels.push(variantValue.value);
              }
            }
          } else {
            if (!option.values.contains(temp.value)) {
              option.values.add(temp.value);
              if (variantValue.label != null) {
                option.labels.add(variantValue.label);
              } else {
                if (variantValue.variantType != null &&
                    variantValue.variantType.variantTypeValues != null) {
                  variantValue.variantType.variantTypeValues.forEach((v) {
                    if (variantValue.value.toString() == v.value) {
                      option.labels.add(v.name);
                    }
                  });
                }
                // option.labels.push(variantValue.value);
              }
            }
          }
        }
      });

//      type.variantTypeValues.forEach((vtv) {
//        print("variant type value $vtv");
//        option.labels.add(vtv.name);
//        option.values.add(vtv.value);
//      });
//      variantOptions.add(option);
      if (selectedSku != null) {
        VariantTypeValue temp;
        temp = selectedSku.variantValues[i].variantType.variantTypeValues
            .firstWhere((finder) =>
                finder.id.toString() == selectedSku.variantValues[i].value);
        if (temp == null && !(selectedSku.variantValues[i].value is int)) {
          temp = VariantTypeValue(0, selectedSku.variantValues[i].label,
              selectedSku.variantValues[i].value, 0);
        }
        if (temp != null) {
          option.selectedValue = temp.value;
        }
      }
      if (option.selectedValue == null) {
        option.selectedValue = option.values != null ? option.values[0] : "";
      }
      variantOptions.add(option);
    }

    return variantOptions;
  }
}

// state
abstract class ProductDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoadInProgress extends ProductDetailState {}

class ProductDetailLoadComplete extends ProductDetailState {}

class ProductDetailLoadFailed extends ProductDetailState {}

class ProductDetailPriceUpdateInProgress extends ProductDetailState {}

class ProductDetailPriceUpdateComplete extends ProductDetailState {}

class ProductDetailPriceUpdateFailed extends ProductDetailState {
  final bool priceError;
  final bool stockError;
  final bool noSkuError;

  ProductDetailPriceUpdateFailed(
      {this.priceError = false,
      this.stockError = false,
      this.noSkuError = false});

  @override
  List<Object> get props => [priceError, stockError, noSkuError];
}

class ProductDetailAddToCartInProgress extends ProductDetailState {}

class ProductDetailAddToCartComplete extends ProductDetailState {}

class ProductDetailAddToCartFailed extends ProductDetailState {}

class ProductDetailSelectAddressComplete extends ProductDetailState {
  final Location address;

  ProductDetailSelectAddressComplete(this.address);

  @override
  List<Object> get props => [address];
}

// event
abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductDetailLoad extends ProductDetailEvent {}

class ProductDetailChangeQuantity extends ProductDetailEvent {
  final int quantity;

  ProductDetailChangeQuantity(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class ProductDetailAddToCart extends ProductDetailEvent {}

class ProductDetailVariantSelection extends ProductDetailEvent {
  final VariantOption variantOption;
  final String value;

  ProductDetailVariantSelection({this.variantOption, this.value});

  @override
  List<Object> get props => [variantOption, this.value];
}

class ProductDetailSelectAddress extends ProductDetailEvent {
  final int id;

  ProductDetailSelectAddress(this.id);

  @override
  List<Object> get props => [id];
}
