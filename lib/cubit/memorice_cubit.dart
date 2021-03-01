import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:memorice/memorice.dart';
import 'package:memorice/memorice_builder.dart';

class MemoriceCubit extends Cubit<LinkedHashMap<int, Memorice>> {
  Memorice _previous;
  Memorice _current;
  int _length;

  MemoriceCubit(int length)
      : _length = length,
        super(MemoriceBuilder.builder(length));

  void tapCard(Memorice memorice) async {
    evaluateTap();
    if (_previous == memorice) return;
    _current = memorice;
    if (_previous == null) {
      _previous = memorice;
      state[_previous.id].tap();
      _current = null;
      emit(LinkedHashMap<int, Memorice>()..addAll(state));
    } else if (_previous.image == memorice.image) {
      state[memorice.id].discovered();
      state[_previous.id].discovered();
      emit(LinkedHashMap<int, Memorice>()..addAll(state));
      _previous = null;
      _current = null;
    } else {
      state[memorice.id].undiscovered();
      state[_previous.id].undiscovered();
      emit(LinkedHashMap<int, Memorice>()..addAll(state));
    }
  }

  void restart() {
    _current = null;
    _previous = null;
    final newBoard = MemoriceBuilder.builder(_length);
    emit(LinkedHashMap<int, Memorice>()..addAll(newBoard));
  }

  void evaluateTap() {
    if (_current != null && _previous != null) {
      state[_current.id].reset();
      state[_previous.id].reset();
      _current = null;
      _previous = null;
      emit(LinkedHashMap<int, Memorice>()..addAll(state));
    }
  }
}
