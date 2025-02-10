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

        // if (event.email == "") {
        //   throw Exception("Email must not be empty");
        // }
        // if (event.password == "") {
        //   throw Exception("Password must not be empty");
        // }
        // if (event.confirmPassword == "") {
        //   throw Exception("Confirm Password must not be empty");
        // }
        // if (event.password.length < 6) {
        //   throw Exception("Password must be at least 6 characters long");
        // }

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
