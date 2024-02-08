part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

 class  SignUpSubmittedEvent extends SignUpEvent{
   final String email ;
   final String password ;
   final String cPassword ;
   final String username ;
   SignUpSubmittedEvent(this.email ,this.password, this.cPassword, this.username);
 }
class SignUpTextChangedEvent extends SignUpEvent{
  final String email ;
  final String password ;
  final String cPassword ;
  final String username ;
  SignUpTextChangedEvent(this.email ,this.password, this.cPassword, this.username);
}
