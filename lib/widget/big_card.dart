import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorice/cubit/memorice_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigCard extends StatelessWidget {
  final int length;
  const BigCard({this.length, Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final id = Random().nextInt(length);
    final memorice = context.watch<MemoriceCubit>().state[id];

    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(memorice.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
