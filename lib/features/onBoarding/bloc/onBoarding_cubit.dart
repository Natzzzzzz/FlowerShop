import 'package:flutter_bloc/flutter_bloc.dart';
import 'onBoarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingPageState(0, false));

  void changePage(int currentPage) {
    emit(OnboardingPageState(currentPage, currentPage == 3));
  }
}
