import 'package:bloc/bloc.dart';
import 'package:memorice/cubit/counter_cubit.dart';
import 'package:memorice/cubit/memorice_cubit.dart';
import 'package:memorice/memorice.dart';

enum GameState { Initial, Played, Won }

class GameCubit extends Cubit<GameState> {
  final CounterCubit counterCubit;
  final MemoriceCubit memoriceCubit;

  GameCubit({this.counterCubit, this.memoriceCubit})
      : super(GameState.Initial) {
    memoriceCubit.listen((memorice) {
      final count = memorice.values
          .where((mem) => mem.cardState == CardState.Discovered)
          .length;
      if (count == memorice.values.length) {
        won();
      }
    });
  }

  void start() {
    emit(GameState.Played);
    memoriceCubit.restart();
    counterCubit.start();
  }

  void won() {
    counterCubit.stop();
    emit(GameState.Won);
  }

  void restart() {
    counterCubit.restart();
    memoriceCubit.restart();
  }

  void initialize() {
    emit(GameState.Initial);
    memoriceCubit.restart();
    counterCubit.stop();
  }
}
