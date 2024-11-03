// counter_bloc.dart
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounter) {
      yield state + 1;
    } else if (event is DecrementCounter) {
      yield state - 1;
    }
  }

  // Restore state from JSON
  @override
  int fromJson(Map<String, dynamic> json) {
    return json['value'] as int;
  }

  // Convert state to JSON
  @override
  Map<String, dynamic> toJson(int state) {
    return {'value': state};
  }
}
