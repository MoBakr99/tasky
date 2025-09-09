part of 'index_controller.dart';

abstract class IndexEvent {}

class ChangeIndex extends IndexEvent {
  final int index;

  ChangeIndex(this.index);
}
