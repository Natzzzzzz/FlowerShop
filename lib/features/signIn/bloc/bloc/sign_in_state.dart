abstract class SignInState {}

class Unauthenticated extends SignInState {}

class Authenticating extends SignInState {}

class Authenticated extends SignInState {
  final String userEmail;
  Authenticated(this.userEmail);
}

class AuthenticationError extends SignInState {
  final String message;
  AuthenticationError(this.message);
}
