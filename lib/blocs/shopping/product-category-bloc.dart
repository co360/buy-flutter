import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/shopping/category.dart';
import 'package:storeFlutter/models/query-result-category.dart';
import 'package:storeFlutter/services/product-category-service.dart';

// bloc
class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final ProductCategoryService _productCategory =
      GetIt.I<ProductCategoryService>();

  ProductCategoryBloc() : super(ProductCategoryInitial());

  @override
  Stream<ProductCategoryState> mapEventToState(
      ProductCategoryEvent event) async* {
    if (event is LoadProductCategoryEvent) {
      try {
        QueryResultCategory result =
            await _productCategory.loadProductCategory(event.id);
        print("ProductCategoryBloc");
        print(result);
        int index = result.layer1Category.indexWhere((c) => c.id == event.id);
        yield ProductCategoryLists(result, index);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductCategoryError(_.toString());
      }
    } else if (event is SwitchProductCategoryEvent) {
      try {
        QueryResultCategory result =
            await _productCategory.switchProductCategory(event.id);
        print("ProductCategoryBloc");
        print(result);
        int index = result.layer1Category.indexWhere((c) => c.id == event.id);
        yield ProductCategoryLists(result, index);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield ProductCategoryError(_.toString());
      }
    }
  }
}

// state
abstract class ProductCategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductCategoryInitial extends ProductCategoryState {}

class ProductCategoryLists extends ProductCategoryState {
  final QueryResultCategory categories;
  final int layerOneIndex;

  ProductCategoryLists(this.categories, this.layerOneIndex);

  @override
  List<Object> get props => [categories];
}

class ProductCategoryError extends ProductCategoryState {
  final String error;

  ProductCategoryError(this.error);

  @override
  List<Object> get props => [error];
}

// event
abstract class ProductCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductCategoryEvent extends ProductCategoryEvent {
  final int id;

  LoadProductCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SwitchProductCategoryEvent extends ProductCategoryEvent {
  final int id;

  SwitchProductCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}
