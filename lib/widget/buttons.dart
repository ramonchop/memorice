import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorice/cubit/game_cubit.dart';

class Buttons extends StatelessWidget {
  Buttons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameCubit>().state;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        state == GameState.Played ? _ResetButton() : _StartButton(),
        state != GameState.Initial ? _HomeButton() : Container(),
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Button(
      onPressed: () => context.read<GameCubit>().initialize(),
      text: 'Home',
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Button(
      onPressed: () => context.read<GameCubit>().start(),
      text: 'Start',
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Button(
      onPressed: () => context.read<GameCubit>().restart(),
      text: 'Reset',
    );
  }
}

class _Button extends StatelessWidget {
  final Function onPressed;
  final String text;

  const _Button({this.onPressed, this.text, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(
          text,
        ),
      ),
    );
  }
}
