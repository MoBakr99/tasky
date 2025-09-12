part of 'user_controller.dart';

abstract class NameEvent {}

class ChangeName extends NameEvent {
  final String newName;

  ChangeName(this.newName);
}

class ChangeQuote extends NameEvent {
  final String newQuote;

  ChangeQuote(this.newQuote);
}
