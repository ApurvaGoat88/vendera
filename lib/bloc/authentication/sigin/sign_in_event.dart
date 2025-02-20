part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInSubmittedEvent extends SignInEvent{
  final String email ;
  final String password ;

  SignInSubmittedEvent(this.email ,this.password);

}
class SigInInitialEvent extends SignInEvent{}

class SignInTextChangedEvent extends SignInEvent{
  final String email ;
  final String password ;

  SignInTextChangedEvent(this.email ,this.password);
}