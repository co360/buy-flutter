import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/models/shopping/sales-cart.dart';
import 'package:storeFlutter/services/sales-cart-service.dart';

// bloc
class SalesCartBloc extends Bloc<SalesCartEvent, SalesCartState> {
  final SalesCartService _salesCartService = GetIt.I<SalesCartService>();

  final AuthBloc authBloc;
  StreamSubscription authSubscription;

  SalesCartBloc(this.authBloc) : super(SalesCartInitial()) {
    authSubscription = authBloc.listen((state) {
      if (state is LoginSuccess) {
        add(SalesCartRefresh());
      } else if (state is LogoutSuccess || state is LoginFailure) {
        // TODO clear the sales cart
        add(SalesCartRefresh());
      }
    });
  }

  @override
  Stream<SalesCartState> mapEventToState(SalesCartEvent event) async* {
    if (event is SalesCartRefresh) {
      yield SalesCartRefreshInProgress();

      try {
        SalesCart salesCart = await _salesCartService.refreshSalesCart();
        yield SalesCartRefreshComplete(salesCart);
      } catch (_, stacktrace) {
        print(stacktrace);
        yield SalesCartRefreshFailed(_.toString());
      }
    } else if (event is SalesCartClear) {
      yield SalesCartRefreshFailed("clear cart");
    }
  }
}

// state
abstract class SalesCartState extends Equatable {
  @override
  List<Object> get props => [];
}

class SalesCartInitial extends SalesCartState {}

class SalesCartRefreshInProgress extends SalesCartState {}

class SalesCartRefreshComplete extends SalesCartState {
  final SalesCart cart;

  SalesCartRefreshComplete(this.cart);

  @override
  List<Object> get props => [cart];
}

class SalesCartRefreshFailed extends SalesCartState {
  final String error;

  SalesCartRefreshFailed(this.error);

  @override
  List<Object> get props => [error];
}

// event

abstract class SalesCartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SalesCartRefresh extends SalesCartEvent {}

class SalesCartClear extends SalesCartEvent {}

class SalesCartAdd extends SalesCartEvent {}

class SalesCartRemove extends SalesCartEvent {}
