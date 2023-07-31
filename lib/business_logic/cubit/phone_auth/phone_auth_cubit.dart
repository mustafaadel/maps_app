import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());
  String verificationId = "";

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$phoneNumber',
        timeout: const Duration(seconds: 15),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    print("verificationCompleted");
    await signIn(phoneAuthCredential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print("verificationFailed : ${error.toString()}");
    emit(PhoneAuthFailure(errorMessage: error.toString()));
  }

  void codeSent(String vId, int? forceResendingToken) {
    print(vId);
    this.verificationId = vId;
    print(verificationId);
    print("codeSent : $verificationId");

    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print("codeAutoRetrievalTimeout : $verificationId");
    emit(PhoneNumberSubmitted());
  }

  Future<void> submitOTP(String otp) async {
    print("dakhel submit otp");
    print(verificationId);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await signIn(phoneAuthCredential);
  }

  Future<void> signIn(PhoneAuthCredential phoneAuthCredential) async {
    emit(PhoneAuthLoading());
    print("gowa el sign in");
    try {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      emit(PhoneOTPVerified());
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(PhoneAuthInitial());
  }

  User? getLoggedInUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
