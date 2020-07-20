import 'package:flutter_bloc/flutter_bloc.dart';

class LoggingBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('### Event On Bloc : $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('### Transition On Bloc : $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('### Error On Bloc : $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
