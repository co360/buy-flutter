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
      yield ProductListingSearchInProgress();

      try {
        QueryResult<Product> result =
            await _productService.searchProduct(event.query);
        yield ProductListingSearchComplete(result);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductListingSearchError(_.toString());
      }
    } else if (event is ProductListingNextPage) {
      yield ProductListingSearchInProgress();

      try {
        QueryResult<Product> result = await _productService
            .searchProduct(event.query, page: event.result.page + 1);
        yield ProductListingSearchComplete(result);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductListingSearchError(_.toString());
      }
    }
  }
}

// state
abstract class ProductListingState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductListingInitial extends ProductListingState {}

class ProductListingSearchInProgress extends ProductListingState {}

class ProductListingSearchError extends ProductListingState {
  final String error;

  ProductListingSearchError(this.error);

  @override
  List<Object> get props => [error];
}

class ProductListingSearchComplete extends ProductListingState {
  // TODO all the info like list of products, page number
  // still need page number if we going to do infinite scrolling

  final QueryResult<Product> result;

  ProductListingSearchComplete(this.result);
  @override
  List<Object> get props => [result];

//  final dynamic data;
//
//  ProductListingSearchComplete(this.data);
//  @override
//  List<Object> get props => [data];
}

// event
abstract class ProductListingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductListingSearch extends ProductListingEvent {
  final String query;
  final QueryResult<Product> result;

  ProductListingSearch(this.query, {this.result});

  @override
  List<Object> get props => [query, this.result];
}

class ProductListingNextPage extends ProductListingEvent {
  final String query;
  final QueryResult<Product> result;

  ProductListingNextPage(this.query, this.result);

  @override
  List<Object> get props => [query, this.result];
}
