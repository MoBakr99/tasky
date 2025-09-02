import 'package:flutter_bloc/flutter_bloc.dart';

class NameState {
  String name;

  NameState([this.name = '']);
}

abstract class NameEvent {}

class ChangeName extends NameEvent {
  final String newName;

  ChangeName(this.newName);
}

class NameController extends Bloc<NameEvent, NameState> {
  NameController([String name = '']) : super(NameState(name)) {
    on<ChangeName>((event, emit) {
      emit(NameState(event.newName));
    });
  }
}
