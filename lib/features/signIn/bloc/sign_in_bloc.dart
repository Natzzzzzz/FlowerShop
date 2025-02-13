import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_delivery/features/signIn/bloc/sign_in_event.dart';
import 'package:flower_delivery/features/signIn/bloc/sign_in_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  SignInBloc(this._firebaseAuth, this._googleSignIn) : super(Unauthenticated()) {
    on<SignInWithEmailPassword>(_onSignInWithEmailPassword);
    on<SignInWithGoogle>(_onSignInWithGoogle);
    
  }

  Future<void> _onSignInWithEmailPassword(
      SignInWithEmailPassword event, Emitter<SignInState> emit) async {
    emit(Authenticating());
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        emit(EmailNotVerified());
      } else {
        emit(Authenticated(user!.email!));
      }
    } catch (error) {
      emit(AuthenticationError('Failed to sign in: $error'));
    }
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogle event, Emitter<SignInState> emit) async {
    emit(Authenticating());
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(Unauthenticated());
        return;
      }
      
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      emit(Authenticated(googleUser.email));
    } catch (error) {
      emit(AuthenticationError('Failed to sign in with Google: $error'));
    }
  }

  // Future<void> _onSignOut(SignOutEvent event, Emitter<SignInState> emit) async {
  //   await _firebaseAuth.signOut();
  //   await _googleSignIn.signOut();
  //   emit(Unauthenticated());
  // }
}
