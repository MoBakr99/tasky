part of 'name_controller.dart';

abstract class NameEvent {}

class ChangeName extends NameEvent {
  final String newName;

  ChangeName(this.newName);
}
