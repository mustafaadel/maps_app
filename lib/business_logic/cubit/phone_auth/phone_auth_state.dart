part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthFailure extends PhoneAuthState {
  final String errorMessage;

  PhoneAuthFailure({required this.errorMessage});
}

class PhoneNumberSubmitted extends PhoneAuthState {
}

class PhoneOTPVerified extends PhoneAuthState {

}

