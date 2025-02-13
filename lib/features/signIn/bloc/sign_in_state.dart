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

class EmailNotVerified extends SignInState {
  final bool canResendEmail;

  EmailNotVerified({this.canResendEmail = true});

  @override
  List<Object?> get props => [canResendEmail];
}

class EmailVerified extends SignInState {}

class EmailVerificationError extends SignInState {
  final String message;

  EmailVerificationError(this.message);

  @override
  List<Object?> get props => [message];
}