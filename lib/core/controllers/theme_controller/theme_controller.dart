import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeController extends Bloc<ThemeEvent, ThemeState> {
  ThemeController(bool isDark) : super(ThemeState(isDark)) {
    on<DarkTheme>((event, emit) {
      emit(ThemeState(true));
    });

    on<LightTheme>((event, emit) {
      emit(ThemeState(false));
    });
  }
}
