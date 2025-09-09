import 'package:flutter_bloc/flutter_bloc.dart';
part 'name_state.dart';
part 'name_event.dart';

class NameController extends Bloc<NameEvent, NameState> {
  NameController([String name = '']) : super(NameState(name)) {
    on<ChangeName>((event, emit) {
      emit(NameState(event.newName));
    });
  }
}
