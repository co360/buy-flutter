import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/shopping/consumer-product-list-price.dart';
import 'package:storeFlutter/models/shopping/minimum-order-quantity.dart';
import 'package:storeFlutter/models/shopping/product-stock-quantity.dart';
import 'package:storeFlutter/models/shopping/quote-item.dart';
import 'package:storeFlutter/models/shopping/sales-cart.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';
import 'package:storeFlutter/services/company-service.dart';
import 'package:storeFlutter/services/consumer-product-list-price-service.dart';
import 'package:storeFlutter/services/minimum-order-quantity-service.dart';
import 'package:storeFlutter/services/product-stock-quantity-service.dart';

// bloc
class SalesCartContentBloc
    extends Bloc<SalesCartContentEvent, SalesCartContentState> {
  final SalesCartBloc salesCartBloc;
  final CompanyService _companyService = GetIt.I<CompanyService>();
  final MinimumOrderQuantityService _minimumOrderQuantityService =
      GetIt.I<MinimumOrderQuantityService>();
  final ProductStockQuantityService _productStockQuantityService =
      GetIt.I<ProductStockQuantityService>();
  final ConsumerProductListPriceService _consumerProductListPriceService =
      GetIt.I<ConsumerProductListPriceService>();

  StreamSubscription salesCartSubscription;

  SalesCart salesCart;
  List<CartGroup> cartGroups = [];

  bool checkAll = false;

  String currency = "";
  int totalItemChecked = 0;
  double totalAmount = 0;

  SalesCartContentBloc(this.salesCartBloc) : super(SalesCartContentInitial()) {
    salesCartSubscription = salesCartBloc.listen((state) {
      print("listen fired");
      if (state is SalesCartRefreshComplete) {
        salesCart = salesCartBloc.salesCart;

        populateCartGroup();

        refreshCartCheckStatus();
        calculateTotal();

        add(SalesCartContentInitContent());
      }
    });
  }

  @override
  Stream<SalesCartContentState> mapEventToState(
      SalesCartContentEvent event) async* {
    if (event is SalesCartContentInitContent) {
      // TODO by right should have default currency by their own country, or hard code to MYR for eDagang
      // then each for the sales quotation need to do currency conversion to convert
      if (salesCart.cartDocs.length > 0) {
        currency = salesCart.cartDocs[0].quoteItems[0].currencyCode;
      }

      yield SalesCartContentLoadingInProgress();
      await updateCartGroupCompany();
      await updatePriceAndQuantity();

//      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentCheckQuotationItem) {
      yield SalesCartContentLoadingInProgress();
      event.quoteItem.checked = event.checkState;

      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentCheckCompany) {
      yield SalesCartContentLoadingInProgress();
      int companyId = event.companyId;

      CartGroup selectedCG = cartGroups
          .firstWhere((cg) => cg.companyId == companyId, orElse: null);

      if (selectedCG != null) checkAllCartGroup(selectedCG, event.checkState);

      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentCheckAll) {
      yield SalesCartContentLoadingInProgress();
//      checkAll = event.checkState;

      // check/uncheck all item
      checkAllItem(event.checkState);

      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentChangeQuantity) {
      yield SalesCartContentLoadingInProgress();

      event.quoteItem.quantity = event.newQuantity.toDouble();

      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    }
  }

  checkAllCartGroup(CartGroup cg, bool checkState) {
//    cg.isChecked = checkState;

    for (int j = 0; j < cg.cartDocs.length; j++) {
      SalesQuotation sq = cg.cartDocs[j];
      for (int k = 0; k < sq.quoteItems.length; k++) {
        QuoteItem qi = sq.quoteItems[k];
        qi.checked = checkState;
      }
    }
  }

  checkAllItem(bool checkState) {
    for (int i = 0; i < cartGroups.length; i++) {
      CartGroup cg = cartGroups[i];
      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];
        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];
          qi.checked = checkState;
        }
      }
    }
  }

  refreshCartCheckStatus() {
    totalItemChecked = 0;
    // Note : can only populate based on item... not the other way round here
    checkAll = true;

    for (int i = 0; i < cartGroups.length; i++) {
      CartGroup cg = cartGroups[i];
      cg.isChecked = true;

      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          cg.isChecked &= (qi.checked != null && qi.checked);
          if (qi.checked != null && qi.checked) {
            totalItemChecked += qi.quantity.toInt();
          }
        }
      }

      checkAll &= cg.isChecked;
    }
  }

  calculateTotal() {
    double tempTotal = 0;
    // calculate total
    for (int i = 0; i < cartGroups.length; i++) {
      CartGroup cg = cartGroups[i];
      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          print("qi is checked ${qi.checked}");
          if (qi.checked != null && qi.checked) {
            tempTotal += qi.invoicePrice * qi.quantity;
          }
        }
      }
    }
//    total = cartGroups.fold(0, (previousValue, cartGroup) => cartGroup.cartDocs.fold(previousValue, (pv, cd) => cd.quote))

    this.totalAmount = tempTotal;
  }

  populateCartGroup() {
    List<CartGroup> cartGroups = [];

    for (int i = 0; i < this.salesCart.cartDocs.length; i++) {
      SalesQuotation salesQuotation = this.salesCart.cartDocs[i];

      CartGroup group = cartGroups.firstWhere(
          (temp) =>
              temp.companyId == salesQuotation.quoteItems[0].product.companyId,
          orElse: () => null);

      if (group != null) {
        group.cartDocs.add(salesQuotation);
      } else {
        group = CartGroup();
        group.isChecked = true;
        cartGroups.add(group);
        group.companyId = salesQuotation.quoteItems[0].product.companyId;
//        group.company = await _companyService.getCompany(group.companyId);
        group.company = salesQuotation.quoteItems[0].product.sellerCompany;
        group.cartDocs.add(salesQuotation);
      }
    }

    this.salesCart.cartDocs.map((salesQuotation) async {}).toList();

    this.cartGroups = cartGroups;
  }

  Future<void> updateCartGroupCompany() async {
    for (int i = 0; i < this.cartGroups.length; i++) {
      CartGroup group = cartGroups[i];

      group.company = await _companyService.getCompany(group.companyId);
    }
  }

  Future<void> updatePriceAndQuantity() async {
    for (int j = 0; j < salesCart.cartDocs.length; j++) {
      SalesQuotation sq = salesCart.cartDocs[j];

      for (int k = 0; k < sq.quoteItems.length; k++) {
        QuoteItem qi = sq.quoteItems[k];

        String countryCode = '';

        if (sq.storeShippingOption != null &&
            sq.storeShippingOption.shippingAddress != null) {
          countryCode = sq.storeShippingOption.shippingAddress.countryCode;
        }
        ConsumerProductListPrice price = await _consumerProductListPriceService
            .getPrice(qi.sku.productSkuID, qi.product.companyId, countryCode);

        print("get price in updatePrice $price");
        if (price != null) {
          qi.invoicePrice = price.price;
          qi.currencyCode = price.currency.code;
          qi.uomCode = price.uom.code;
        } else {
          qi.invoicePrice = 0;
        }

        MinimumOrderQuantity minQty = await _minimumOrderQuantityService
            .findMinimumOrder(qi.sku.productSkuID, qi.product.companyId);

        if (minQty != null) {
          qi.minOrderQty = minQty.minQuantity;
        } else {
          qi.minOrderQty = 1;
        }

        ProductStockQuantity stock = await _productStockQuantityService
            .getStock(qi.sku.productSkuID, qi.product.companyId, countryCode);

        if (stock != null) {
          qi.maxOrderQty = stock.stock;
        } else {
          qi.maxOrderQty = 9999;
        }
      }
    }
  }
}

// state
abstract class SalesCartContentState extends Equatable {
  @override
  List<Object> get props => [];
}

class SalesCartContentInitial extends SalesCartContentState {}

class SalesCartContentLoadingInProgress extends SalesCartContentState {}

class SalesCartContentLoadingComplete extends SalesCartContentState {}
// event

abstract class SalesCartContentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SalesCartContentInitContent extends SalesCartContentEvent {}

class SalesCartContentCheckAll extends SalesCartContentEvent {
  final bool checkState;

  SalesCartContentCheckAll(this.checkState);

  @override
  List<Object> get props => [checkState];
}

class SalesCartContentCheckCompany extends SalesCartContentEvent {
  final int companyId;
  final bool checkState;

  SalesCartContentCheckCompany(this.companyId, this.checkState);
  @override
  List<Object> get props => [companyId, checkState];
}

class SalesCartContentCheckQuotationItem extends SalesCartContentEvent {
  final QuoteItem quoteItem;
  final bool checkState;

  SalesCartContentCheckQuotationItem(this.quoteItem, this.checkState);

  @override
  List<Object> get props => [quoteItem, checkState];
}

class SalesCartContentChangeQuantity extends SalesCartContentEvent {
  final QuoteItem quoteItem;
  final int newQuantity;

  SalesCartContentChangeQuantity(this.quoteItem, this.newQuantity);

  @override
  List<Object> get props => [quoteItem, newQuantity];
}

class CartGroup {
  int companyId;
  Company company;
  List<SalesQuotation> cartDocs = [];
  bool isChecked = false;
}
