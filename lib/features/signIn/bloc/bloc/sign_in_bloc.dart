import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_delivery/features/signIn/bloc/bloc/sign_in_event.dart';
import 'package:flower_delivery/features/signIn/bloc/bloc/sign_in_state.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GoogleSignIn _googleSignIn;

  SignInBloc(this._googleSignIn) : super(Unauthenticated()) {

    on<SignInWithGoogle>((event, emit) async {
      emit(Authenticating());
      try {
        await _googleSignIn.signOut();
        //begin interactive sign in process
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        //obtain the authentication details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

        //create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(Authenticated(googleUser.email));
      
      } catch (error) {
        emit(AuthenticationError('Failed to sign in with Google: $error'));
      }
    });
  }
}
