import 'package:flutter_bloc/flutter_bloc.dart';

part 'priority_state.dart';
part 'priority_event.dart';

class PriorityController extends Bloc<PriorityEvent, PriorityState> {
  PriorityController([bool highPriority = false])
      : super(PriorityState(highPriority: highPriority)) {
    on<ChangePriority>((event, emit) {
      emit(PriorityState(highPriority: event.newPriority));
    });
  }
}
