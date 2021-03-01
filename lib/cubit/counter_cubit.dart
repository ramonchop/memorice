import 'dart:async';
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  Timer timer;
  CounterCubit() : super(0);

  void start() async {
    int count = 0;
    emit(count);
    timer = new Timer.periodic(new Duration(seconds: 1), (_) {
      count++;
      emit(count);
    });
  }

  void stop() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  void restart() async {
    stop();
    start();
  }
}
