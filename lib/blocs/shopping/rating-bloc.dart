import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/order-rate-review-service.dart';
import 'package:storeFlutter/models/shopping/order-rate-review.dart';

// bloc
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final OrderRateReviewService _ratingService =
      GetIt.I<OrderRateReviewService>();

  RatingBloc() : super(RatingInitial());

  @override
  Stream<RatingState> mapEventToState(RatingEvent event) async* {
    if (event is LoadRatingByCompanyIdEvent) {
      List<OrderRateReview> status =
          await _ratingService.getByCompanyId(event.id);
      print(status);
      if (status != null && status.length > 0) {
        yield LoadRatingSuccess(status);
      } else {
        yield LoadRatingFailed();
      }
    }
    if (event is LoadRatingByProductIdEvent) {
      List<OrderRateReview> status =
          await _ratingService.getByProductId(event.id);
      print(status);
      if (status != null) {
        yield LoadRatingSuccess(status);
      } else {
        yield LoadRatingFailed();
      }
    }
    if (event is LoadRatingBySalesOrderIdEvent) {
      List<OrderRateReview> status =
          await _ratingService.getBySalesOrderId(event.id);
      print(status);
      if (status != null && status.length > 0) {
        yield LoadRatingSuccess(status);
      } else {
        yield LoadRatingFailed();
      }
    } else if (event is InitRatingEvent) {
      yield RatingInitial();
    }
  }
}

// state
abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class LoadRatingSuccess extends RatingState {
  final List<OrderRateReview> ratings;

  LoadRatingSuccess(this.ratings);

  @override
  List<Object> get props => [ratings];
}

class LoadSingleRatingSuccess extends RatingState {
  final OrderRateReview rating;

  LoadSingleRatingSuccess(this.rating);

  @override
  List<Object> get props => [rating];
}

class LoadRatingFailed extends RatingState {}

// Event
abstract class RatingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRatingByCompanyIdEvent extends RatingEvent {
  final int id;

  LoadRatingByCompanyIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadRatingByProductIdEvent extends RatingEvent {
  final int id;

  LoadRatingByProductIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadRatingBySalesOrderIdEvent extends RatingEvent {
  final int id;

  LoadRatingBySalesOrderIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InitRatingEvent extends RatingEvent {}
