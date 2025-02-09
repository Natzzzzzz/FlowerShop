import 'package:flutter/foundation.dart';

@immutable
abstract class OnboardingEvent {}

class PageChangedEvent extends OnboardingEvent {
  final int currentPage;

  PageChangedEvent(this.currentPage);
}
