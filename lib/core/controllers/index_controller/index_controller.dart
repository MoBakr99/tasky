import 'package:flutter_bloc/flutter_bloc.dart';
part 'index_state.dart';
part 'index_event.dart';

class IndexController extends Bloc<IndexEvent, IndexState> {
  IndexController() : super(IndexState()) {
    on<ChangeIndex>((event, emit) {
      emit(IndexState(event.index));
    });
  }
}
