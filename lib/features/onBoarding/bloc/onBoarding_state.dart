import 'package:flutter/foundation.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitialState extends OnboardingState {}

class OnboardingPageState extends OnboardingState {
  final int currentPage;
  final bool isLastPage;

  OnboardingPageState(this.currentPage, this.isLastPage);
}
