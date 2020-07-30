import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/rating-service.dart';
import 'package:storeFlutter/models/shopping/order-rate-review.dart';

// bloc
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingService _ratingService = GetIt.I<RatingService>();

  RatingBloc() : super(RatingInitial());

  @override
  Stream<RatingState> mapEventToState(RatingEvent event) async* {
    if (event is LoadRatingByIDEvent) {
      List<OrderRateReview> status =
          await _ratingService.getAllRatingsByID(event.id);
      print(status);
      if (status != null && status.length > 0) {
        yield RatingSuccess(status);
      } else {
        yield RatingFailed();
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

class RatingSuccess extends RatingState {
  final List<OrderRateReview> ratings;

  RatingSuccess(this.ratings);

  @override
  List<Object> get props => [ratings];
}

class RatingFailed extends RatingState {}

// Event
abstract class RatingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRatingByIDEvent extends RatingEvent {
  final int id;

  LoadRatingByIDEvent(this.id);

  @override
  List<Object> get props => [id];
}

class InitRatingEvent extends RatingEvent {}
