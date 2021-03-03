import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memorice/cubit/counter_cubit.dart';
import 'package:memorice/cubit/game_cubit.dart';
import 'package:memorice/home_page.dart';
import 'package:memorice/cubit/memorice_cubit.dart';

void main() {
  final length = 8;
  runApp(MyApp(length));
}

class MyApp extends StatelessWidget {
  final length;
  MyApp(this.length);

  @override
  Widget build(BuildContext context) {
    final memoriceCubit = MemoriceCubit(length);
    final counterCubit = CounterCubit();
    final gameCubit =
        GameCubit(memoriceCubit: memoriceCubit, counterCubit: counterCubit);
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(constraints,
          designSize: Size(380, 760), allowFontScaling: true);
      return MaterialApp(
        title: 'Memorice',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: memoriceCubit,
            ),
            BlocProvider.value(
              value: counterCubit,
            ),
            BlocProvider.value(
              value: gameCubit,
            ),
          ],
          child: HomePage(
            title: 'Memorice',
          ),
        ),
      );
    });
  }
}
