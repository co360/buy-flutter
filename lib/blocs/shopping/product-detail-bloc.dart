import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/annual-revenue-data-source.dart';
import 'package:storeFlutter/datasource/business-type-data-source.dart';
import 'package:storeFlutter/datasource/total-employee-data-source.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-param.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-response.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/services/company-service.dart';
import 'package:storeFlutter/services/shipment-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

// bloc
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final Product product;
  final BuildContext buildContext;
  SalesQuotation salesQuotation;

  CompanyProfile sellerCompanyProfile;
  Company sellerCompany;
  Location userAddress;
  List<EasyParcelResponse> shipment;

  CompanyService _companyService = GetIt.I<CompanyService>();
  CompanyProfileService _companyProfileService =
      GetIt.I<CompanyProfileService>();
  ShipmentService _shipmentService = GetIt.I<ShipmentService>();
  StorageService _storageService = GetIt.I<StorageService>();

  BusinessTypeDataSource _businessTypeDataSource =
      GetIt.I<BusinessTypeDataSource>();
  List<LabelValue> businessTypeLvs;

  TotalEmployeeDataSource _totalEmployeeDataSource =
      GetIt.I<TotalEmployeeDataSource>();
  List<LabelValue> totalEmployeeLvs;

  AnnualRevenueDataSource _annualRevenueDataSource =
      GetIt.I<AnnualRevenueDataSource>();
  List<LabelValue> annualRevenueLvs;

  ProductDetailBloc({@required this.product, @required this.buildContext})
      : super(ProductDetailInitial()) {
    sellerCompany = this.product.sellerCompany;
    sellerCompanyProfile = this.product.sellerCompanyProfile;

    salesQuotation = SalesQuotation();

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

      yield ProductDetailLoadComplete();
    } else if (event is ProductDetailChangeQuantity) {
      yield ProductDetailPriceUpdateInProgress();

      // TODO set quantity

      yield ProductDetailPriceUpdateComplete();
    } else if (event is ProductDetailSelectSKU) {
      yield ProductDetailPriceUpdateInProgress();

      // TODO set sku

      yield ProductDetailPriceUpdateComplete();
    } else if (event is ProductDetailAddToCart) {
      yield ProductDetailAddToCartInProgress();

      // TODO add to cart

      yield ProductDetailAddToCartComplete();

      // TODO triger sales cart bloc to refresh...
    }
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

class ProductDetailPriceUpdateFailed extends ProductDetailState {}

class ProductDetailAddToCartInProgress extends ProductDetailState {}

class ProductDetailAddToCartComplete extends ProductDetailState {}

class ProductDetailAddToCartFailed extends ProductDetailState {}

// event
abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductDetailLoad extends ProductDetailEvent {}

class ProductDetailSelectSKU extends ProductDetailEvent {
  final Sku sku;

  ProductDetailSelectSKU(this.sku);

  @override
  List<Object> get props => [sku];
}

class ProductDetailChangeQuantity extends ProductDetailEvent {
  final int quantity;

  ProductDetailChangeQuantity(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class ProductDetailAddToCart extends ProductDetailEvent {}
