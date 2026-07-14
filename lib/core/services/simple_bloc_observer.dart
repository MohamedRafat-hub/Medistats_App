import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver implements BlocObserver{
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log('onChange: $change and bloc is $bloc');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('onClose: $bloc');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log('onCreate: $bloc');
  }

  @override
  void onDone(Bloc<dynamic, dynamic> bloc, Object? event, [Object? error, StackTrace? stackTrace]) {
    log('onDone: $bloc');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError: $bloc');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log('onEvent: $bloc');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    log('onTransition: $bloc');
  }
}