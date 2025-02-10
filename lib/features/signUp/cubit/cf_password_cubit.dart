import 'package:bloc/bloc.dart';

class ConfirmPasswordVisibilityCubit extends Cubit<bool> {
  ConfirmPasswordVisibilityCubit() : super(false);

  void toggleVisibility() => emit(!state);
}