import 'package:flutter/material.dart';

enum CardState { Initial, Tapped, Discovered, Undiscovered }

class Memorice {
  final String image;
  final int id;
  CardState _cardState;

  Memorice({this.id, this.image, CardState cardState = CardState.Initial})
      : _cardState = cardState;

  get cardState => _cardState;

  void tap() => _cardState = CardState.Tapped;
  void undiscovered() => _cardState = CardState.Undiscovered;
  void discovered() => _cardState = CardState.Discovered;
  void reset() => _cardState = CardState.Initial;

  bool showImage() => _cardState != CardState.Initial;

  Color currentColor() {
    switch (cardState) {
      case CardState.Tapped:
        return Colors.blue;
      case CardState.Discovered:
        return Colors.green;
      case CardState.Undiscovered:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  String toString() {
    return '[id:$id, _cardState: $_cardState]';
  }
}
