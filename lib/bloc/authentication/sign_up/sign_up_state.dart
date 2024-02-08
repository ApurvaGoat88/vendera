part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}
class SignUpValidState extends SignUpState{}
class SignUpInValidState extends SignUpState{}
class SignUpLoadingState extends SignUpState{}
class SignUpSuccessState extends SignUpState{
  final User? user ;

  SignUpSuccessState({required this.user});

}
class SignUpErrorState extends SignUpState{
  final String error ;

  SignUpErrorState( { required this.error});

}

