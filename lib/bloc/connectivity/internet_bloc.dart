import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity connectivity = Connectivity() ;
  InternetBloc() : super(InternetInitial()) {
    on<InternetGainEvent>((event,emit) => emit(InternetGainState())) ;
    on<InternetLostEvent>((event, emit) => emit(InternetLostState())) ;

    connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi || event == ConnectivityResult.mobile){
        add(InternetGainEvent()) ;
      }
      else{
        add(InternetLostEvent()) ; 
      }
    });
  }
}
