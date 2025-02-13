abstract class SignInEvent {}

class SignInWithGoogle extends SignInEvent {}

class SignInWithEmailPassword extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailPassword({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
