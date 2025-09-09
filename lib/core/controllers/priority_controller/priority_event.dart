part of 'priority_controller.dart';

abstract class PriorityEvent {}

class ChangePriority extends PriorityEvent {
  final bool newPriority;

  ChangePriority(this.newPriority);
}
