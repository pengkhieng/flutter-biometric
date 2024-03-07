import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum LockEvent { start, reset }

class LockBloc extends HydratedBloc<LockEvent, int> {
  Timer? _timer;

  LockBloc() : super(60);

  @override
  Stream<int> mapEventToState(LockEvent event) async* {
    if (event == LockEvent.start) {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        add(LockEvent.reset);
      });
    } else if (event == LockEvent.reset) {
      if (state > 0) {
        yield state - 1;
      }
      if (state == 0) {
        // Screen unlock logic can be implemented here
      }
    }
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['count'] as int?;
  }

  @override
  Map<String, int> toJson(int state) {
    return {'count': state};
  }
}
