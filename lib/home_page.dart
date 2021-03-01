import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memorice/cubit/game_cubit.dart';

import 'package:memorice/cubit/memorice_cubit.dart';
import 'package:memorice/widget/big_card.dart';
import 'package:memorice/widget/buttons.dart';
import 'package:memorice/widget/card_board.dart';
import 'package:memorice/widget/timer_bottom.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameCubit>().state;
    final list = context.watch<MemoriceCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          width: 1.sw,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state != GameState.Initial
                  ? CardBoard(
                      mapCards: list,
                    )
                  : BigCard(
                      length: list.length,
                    ),
              SizedBox(
                height: 30,
              ),
              Buttons(),
              SizedBox(
                height: 30,
              ),
              state != GameState.Initial ? TimerBottom() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
