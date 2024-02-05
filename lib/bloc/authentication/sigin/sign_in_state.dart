part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}
class SignInValidState extends SignInState{}
class SignInInvalidState extends SignInState{}
class SignInErrorState extends SignInState{
  final String error ;
  SignInErrorState(this.error);
}
class SignInLoadingState extends SignInState{}