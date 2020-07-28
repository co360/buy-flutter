import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBloc extends Bloc<int, int> {
  BottomNavigationBloc() : super(0);

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}
//class BottomNavigationBloc extends Bloc<BottomPage, BottomPage> {
//  BottomNavigationBloc() : super(BottomPage.home);
//
//  @override
//  Stream<BottomPage> mapEventToState(BottomPage event) async* {
//    yield event;
//  }
//}
//
//// state
//
//// event
//
//abstract class BottomNavigationEvent extends Equatable {
//
//  @override
//  List<Object> get props => [];
//}
//
//class BottomNavigationTap extends BottomNavigationEvent {
//  final int index;
//
//  BottomNavigationTap(this.index);
//
//  @override
//  List<Object> get props => [index];
//}

enum BottomPage { home, orders, cart, account }
