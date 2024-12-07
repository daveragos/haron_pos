import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver{

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    debugPrint(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());

  }

  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    debugPrint(bloc.toString());
  }
}