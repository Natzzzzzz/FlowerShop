import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpSubmitted({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}
