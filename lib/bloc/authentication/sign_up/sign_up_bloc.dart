import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:vendera/models/user_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      // TODO: implement event handler
      emit(SignUpInitial());
      on<SignUpTextChangedEvent>((event, emit) {

         if (event.username.isEmpty) {
        emit(SignUpErrorState(error: 'Create a username'));
        }
        else if (EmailValidator.validate(event.email) == false) {
          emit(SignUpErrorState(error: 'Enter a valid email'));
        } else if (event.password.length <= 7 || event.cPassword.length <= 7) {
          emit(SignUpErrorState(error: 'Password must be more than 7 letters'));
        } else if (event.password != event.cPassword) {
          emit(SignUpErrorState(error: 'Password is not the same'));
        } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(event.username)) {
          emit(SignUpErrorState(error: 'Username can only contain alphanumeric characters'));
        } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$").hasMatch(event.password)) {
          emit(SignUpErrorState(error: 'Password must contain at least one lowercase letter, one uppercase letter, and one digit'));
        } else {
          emit(SignUpValidState());
        }
      });
      on<SignUpSubmittedEvent>((event, emit) async {
        emit(SignUpLoadingState());

      });
    });
  }
}
