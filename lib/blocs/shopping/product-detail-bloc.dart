import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/services/company-service.dart';

// bloc
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final Product product;
  SalesQuotation salesQuotation;

  CompanyProfile sellerCompanyProfile;
  Company sellerCompany;

  CompanyService _companyService = GetIt.I<CompanyService>();
  CompanyProfileService _companyProfileService =
      GetIt.I<CompanyProfileService>();

  ProductDetailBloc({@required this.product}) : super(ProductDetailInitial()) {
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

      // TODO some other data source to resolve?
      // business type etc...

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