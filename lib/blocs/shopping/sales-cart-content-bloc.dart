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

  // checkout mode
  bool checkAll = false;
  String currency = "";
  int totalItemChecked = 0;
  double totalAmount = 0;

  // edit mode
  bool editCheckAll = false;
  int totalItemEditChecked = 0;

  ScreenMode screenMode = ScreenMode.checkout;

  SalesCartContentBloc(this.salesCartBloc) : super(SalesCartContentInitial()) {
    salesCartSubscription = salesCartBloc.listen((state) {
      if (state is SalesCartRefreshComplete) {
        print("listen fired");
        salesCart = salesCartBloc.salesCart;

        populateCartGroup();

        refreshCartCheckStatus();
        calculateTotal();

        add(SalesCartContentInitContent(completer: state.completer));
      }
    });
  }

  int get totalCart {
    if (salesCart == null) return 0;
    return salesCart.totalItems;
  }

  @override
  Stream<SalesCartContentState> mapEventToState(
      SalesCartContentEvent event) async* {
    if (event is SalesCartContentInitContent) {
      // TODO by right should have default currency by their own country, or hard code to MYR for eDagang
      // then each for the sales quotation need to do currency conversion to convert
      if (salesCart != null && salesCart.cartDocs.length > 0) {
        currency = salesCart.cartDocs[0].quoteItems[0].currencyCode;
      }

      yield SalesCartContentLoadingInProgress();
      await updateCartGroupCompany();
      await updatePriceAndQuantity();

//      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();

      if (event.completer != null) event.completer.complete(true);
    } else if (event is SalesCartContentCheckQuotationItem) {
      yield SalesCartContentLoadingInProgress();

      if (screenMode == ScreenMode.edit) {
        event.quoteItem.screenEditChecked = event.checkState;

        refreshCartEditCheckStatus();
      } else {
        event.quoteItem.screenChecked = event.checkState;

        refreshCartCheckStatus();
        calculateTotal();
      }

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentCheckCompany) {
      yield SalesCartContentLoadingInProgress();
      int companyId = event.companyId;

      CartGroup selectedCG = cartGroups
          .firstWhere((cg) => cg.companyId == companyId, orElse: null);

      if (selectedCG != null) checkAllCartGroup(selectedCG, event.checkState);

      if (screenMode == ScreenMode.edit) {
        refreshCartEditCheckStatus();
      } else {
        refreshCartCheckStatus();
        calculateTotal();
      }

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentCheckAll) {
      yield SalesCartContentLoadingInProgress();
//      checkAll = event.checkState;

      // check/uncheck all item
      checkAllItem(event.checkState);

      if (screenMode == ScreenMode.edit) {
        refreshCartEditCheckStatus();
      } else {
        refreshCartCheckStatus();
        calculateTotal();
      }

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentChangeQuantity) {
      yield SalesCartContentLoadingInProgress();

      event.quoteItem.quantity = event.newQuantity.toDouble();

      refreshCartCheckStatus();
      calculateTotal();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentScreenEdit) {
      yield SalesCartContentLoadingInProgress();
      screenMode = ScreenMode.edit;
      resetCartEditCheckStatus();

      yield SalesCartContentLoadingComplete();
    } else if (event is SalesCartContentScreenCheckout) {
      yield SalesCartContentLoadingInProgress();
      screenMode = ScreenMode.checkout;

      yield SalesCartContentLoadingComplete();
    }
  }

  checkAllCartGroup(CartGroup cg, bool checkState) {
//    cg.isChecked = checkState;

    for (int j = 0; j < cg.cartDocs.length; j++) {
      SalesQuotation sq = cg.cartDocs[j];
      for (int k = 0; k < sq.quoteItems.length; k++) {
        QuoteItem qi = sq.quoteItems[k];
        if (screenMode == ScreenMode.edit) {
          qi.screenEditChecked = checkState;
        } else {
          qi.screenChecked = checkState;
        }
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
          if (screenMode == ScreenMode.edit) {
            qi.screenEditChecked = checkState;
          } else {
            qi.screenChecked = checkState;
          }
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
      cg.screenChecked = true;

      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          cg.screenChecked &= (qi.screenChecked != null && qi.screenChecked);
          if (qi.screenChecked != null && qi.screenChecked) {
            totalItemChecked += qi.quantity.toInt();
          }
        }
      }

      checkAll &= cg.screenChecked;
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

          if (qi.screenChecked != null && qi.screenChecked) {
            tempTotal += qi.invoicePrice * qi.quantity;
          }
        }
      }
    }
//    total = cartGroups.fold(0, (previousValue, cartGroup) => cartGroup.cartDocs.fold(previousValue, (pv, cd) => cd.quote))

    this.totalAmount = tempTotal;
  }

  refreshCartEditCheckStatus() {
    totalItemEditChecked = 0;
    // Note : can only populate based on item... not the other way round here
    editCheckAll = true;

    for (int i = 0; i < cartGroups.length; i++) {
      CartGroup cg = cartGroups[i];
      cg.screenEditChecked = true;

      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          cg.screenEditChecked &=
              (qi.screenEditChecked != null && qi.screenEditChecked);
          if (qi.screenEditChecked != null && qi.screenEditChecked) {
            totalItemEditChecked++;
          }
        }
      }

      editCheckAll &= cg.screenEditChecked;
    }
  }

  resetCartEditCheckStatus() {
    totalItemEditChecked = 0;
    editCheckAll = false;
    for (int i = 0; i < cartGroups.length; i++) {
      CartGroup cg = cartGroups[i];
      cg.screenEditChecked = false;

      for (int j = 0; j < cg.cartDocs.length; j++) {
        SalesQuotation sq = cg.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          qi.screenEditChecked = false;
        }
      }
    }
  }

  bool hasCarts() {
    return this.salesCart != null &&
        this.salesCart.cartDocs != null &&
        this.salesCart.cartDocs.length > 0;
  }

  populateCartGroup({bool checked = true}) {
    List<CartGroup> cartGroups = [];

    if (hasCarts()) {
      for (int i = 0; i < this.salesCart.cartDocs.length; i++) {
        SalesQuotation salesQuotation = this.salesCart.cartDocs[i];

        CartGroup group = cartGroups.firstWhere(
            (temp) =>
                temp.companyId ==
                salesQuotation.quoteItems[0].product.companyId,
            orElse: () => null);

        if (group != null) {
          group.cartDocs.add(salesQuotation);
        } else {
          group = CartGroup();
          group.screenChecked = checked;
          cartGroups.add(group);
          group.companyId = salesQuotation.quoteItems[0].product.companyId;
//        group.company = await _companyService.getCompany(group.companyId);
          group.company = salesQuotation.quoteItems[0].product.sellerCompany;
          group.cartDocs.add(salesQuotation);
        }

        salesQuotation.quoteItems
            .map((e) => e.screenChecked = checked)
            .toList();
      }
    }

//    this.salesCart.cartDocs.map((salesQuotation) async {}).toList();

    this.cartGroups = cartGroups;
  }

  Future<void> updateCartGroupCompany() async {
    for (int i = 0; i < this.cartGroups.length; i++) {
      CartGroup group = cartGroups[i];

      group.company = await _companyService.getCompany(group.companyId);
    }
  }

  Future<void> updatePriceAndQuantity() async {
    if (hasCarts()) {
      for (int j = 0; j < salesCart.cartDocs.length; j++) {
        SalesQuotation sq = salesCart.cartDocs[j];

        for (int k = 0; k < sq.quoteItems.length; k++) {
          QuoteItem qi = sq.quoteItems[k];

          String countryCode = '';

          if (sq.storeShippingOption != null &&
              sq.storeShippingOption.shippingAddress != null) {
            countryCode = sq.storeShippingOption.shippingAddress.countryCode;
          }
          ConsumerProductListPrice price =
              await _consumerProductListPriceService.getPrice(
                  qi.sku.productSkuID, qi.product.companyId, countryCode);

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

class SalesCartContentInitContent extends SalesCartContentEvent {
  final Completer completer;

  SalesCartContentInitContent({this.completer});

  @override
  List<Object> get props => [completer];
}

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

class SalesCartContentScreenEdit extends SalesCartContentEvent {}

class SalesCartContentScreenCheckout extends SalesCartContentEvent {}

class SalesCartContentDelete extends SalesCartContentEvent {}

class CartGroup {
  int companyId;
  Company company;
  List<SalesQuotation> cartDocs = [];

  bool screenChecked = false;
  bool screenEditChecked = false;
}

enum ScreenMode { checkout, edit }
