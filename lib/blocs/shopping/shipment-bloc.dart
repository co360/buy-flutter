import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-param.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-response.dart';
import 'package:storeFlutter/services/shipment-service.dart';

// bloc
class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  final ShipmentService _shipmentService = GetIt.I<ShipmentService>();

  ShipmentBloc() : super(ShipmentInitial());

  @override
  Stream<ShipmentState> mapEventToState(ShipmentEvent event) async* {
    if (event is GetEasyParcelEvent) {
      yield GetShipmentInProgress();
      List<EasyParcelResponse> status =
          await _shipmentService.getEasyParcel(event.params);
      print(status);
      if (status != null && status.length > 0) {
        yield GetShipmentSuccess(status);
      } else {
        yield GetShipmentFailed();
      }
    } else if (event is InitShipmentEvent) {
      yield ShipmentInitial();
    }
  }
}

// state
abstract class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object> get props => [];
}

class ShipmentInitial extends ShipmentState {}

class GetShipmentInProgress extends ShipmentState {}

class GetShipmentSuccess extends ShipmentState {
  final List<EasyParcelResponse> responses;

  GetShipmentSuccess(this.responses);

  @override
  List<Object> get props => [responses];
}

class GetShipmentFailed extends ShipmentState {}

// Event
abstract class ShipmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEasyParcelEvent extends ShipmentEvent {
  final EasyParcelParam params;

  GetEasyParcelEvent(this.params);

  @override
  List<Object> get props => [params];
}

class InitShipmentEvent extends ShipmentEvent {}
