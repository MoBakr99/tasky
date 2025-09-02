import 'package:flutter_bloc/flutter_bloc.dart';

class IndexState {
  int index;

  IndexState([this.index = 0]);
}

abstract class IndexEvent {}

class ChangeIndex extends IndexEvent {
  final int index;

  ChangeIndex(this.index);
}

class IndexController extends Bloc<IndexEvent, IndexState> {
  IndexController() : super(IndexState()) {
    on<ChangeIndex>((event, emit) {
      emit(IndexState(event.index));
    });
  }
}
