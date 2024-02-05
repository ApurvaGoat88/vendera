import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {

    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
      on<SignInTextChangedEvent>((event, emit){

        if  (EmailValidator.validate(event.email) == false) {
          emit(SignInErrorState('Please enter a valid email Address'));
        }
        else if (event.password.isEmpty || event.password.length <=7){
          emit(SignInErrorState('Password must be more than 7 letters ')) ;
        }
        else{
          emit(SignInValidState());
        }
      });
      on<SignInSubmittedEvent>((event, emit){
        emit(SignInLoadingState());
      });
    });
  }
}