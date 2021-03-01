import 'package:flutter/material.dart';
import 'package:memorice/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBottom extends StatelessWidget {
  const TimerBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline5;
    final state = context.watch<CounterCubit>().state;
    return Center(
      child: Text(
        formatTime(state),
        style: style,
      ),
    );
  }

  String formatTime(int secs) {
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }
}
