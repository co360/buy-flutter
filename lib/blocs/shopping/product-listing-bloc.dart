import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/query-result.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/services/product-service.dart';

// bloc
class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  final ProductService _productService = GetIt.I<ProductService>();

  ProductListingBloc() : super(ProductListingInitial());

  @override
  Stream<ProductListingState> mapEventToState(
      ProductListingEvent event) async* {
    if (event is ProductListingSearch) {
      yield ProductListingSearchInProgress(QueryResult<Product>());

      try {
        QueryResult<Product> result =
            await _productService.searchProduct(event.queryFilter);
        yield ProductListingSearchComplete(result, event.queryFilter);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductListingSearchError(_.toString());
      }
    } else if (event is ProductListingNextPage) {
      yield ProductListingSearchInProgress(event.result);

      try {
        QueryResult<Product> result = await _productService
            .searchProduct(event.queryFilter, page: event.result.page + 1);

        // append result from previous search
        List<Product> newResult = [];
        newResult.addAll(event.result.items);
        newResult.addAll(result.items);

        result.items = newResult;

        yield ProductListingSearchComplete(result, event.queryFilter);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductListingSearchError(_.toString());
      }
    } else if (event is ProductListingSearchReset) {
        yield ProductListingCategoryResetState();
    }
  }
}

// state
abstract class ProductListingState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductListingInitial extends ProductListingState {}

class ProductListingSearchInProgress extends ProductListingState {
  final QueryResult<Product> result;

  ProductListingSearchInProgress(this.result);

  @override
  List<Object> get props => [result];
}

class ProductListingSearchError extends ProductListingState {
  final String error;

  ProductListingSearchError(this.error);

  @override
  List<Object> get props => [error];
}

class ProductListingSearchComplete extends ProductListingState {
  final ProductListingQueryFilter queryFilter;
  final QueryResult<Product> result;

  ProductListingSearchComplete(this.result, this.queryFilter);
  @override
  List<Object> get props => [result, queryFilter];

//  final dynamic data;
//
//  ProductListingSearchComplete(this.data);
//  @override
//  List<Object> get props => [data];
}

class ProductListingCategoryResetState extends ProductListingState {}

// event
abstract class ProductListingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductListingSearch extends ProductListingEvent {
  final ProductListingQueryFilter queryFilter;
  final QueryResult<Product> result;

  ProductListingSearch(this.queryFilter, {this.result});

  @override
  List<Object> get props => [queryFilter, this.result];
}

class ProductListingNextPage extends ProductListingEvent {
  final ProductListingQueryFilter queryFilter;
  final QueryResult<Product> result;

  ProductListingNextPage(this.queryFilter, this.result);

  @override
  List<Object> get props => [queryFilter, this.result];
}

class ProductListingSearchReset extends ProductListingEvent {}