import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserController extends Bloc<NameEvent, UserState> {
  UserController(String name, String quote) : super(UserState(name, quote)) {
    on<ChangeName>((event, emit) {
      emit(UserState(event.newName, state.quote));
    });

    on<ChangeQuote>((event, emit) {
      emit(UserState(state.name, event.newQuote));
    });
  }
}
