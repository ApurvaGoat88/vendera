part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetInitial extends InternetState {}
class InternetLostState extends InternetState {}
class InternetGainState extends InternetState {}


