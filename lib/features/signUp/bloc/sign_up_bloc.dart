import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_delivery/features/signUp/bloc/sign_up_event.dart';
import 'package:flower_delivery/features/signUp/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {

    on<SignUpSubmitted>((event, emit) async {
      // Validate the input
      if (event.password != event.confirmPassword) {
        emit(SignUpFailure(error: "Passwords do not match"));
        return;
      }

      // Simulate sign-up process
      try {
        emit(SignUpLoading());

        // Sign-up with Firebase Auth
        if (event.password == event.confirmPassword){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          
        }
        // If sign-up succeeds
        emit(SignUpSuccess());
      } on FirebaseAuthException catch (error) {
        // If an error occurs during sign-up
        emit(SignUpFailure(error: error.toString()));
      }
    });
  }
}
