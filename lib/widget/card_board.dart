import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorice/memorice.dart';
import 'package:memorice/cubit/memorice_cubit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBoard extends StatelessWidget {
  CardBoard({this.mapCards, Key key}) : super(key: key);
  final LinkedHashMap<int, Memorice> mapCards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: mapCards.entries
          .map((i) => _MemoryCard(
                i.key,
              ))
          .toList(),
    );
  }
}

class _MemoryCard extends StatelessWidget {
  final int id;
  _MemoryCard(this.id, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final memorice = context.watch<MemoriceCubit>().state[id];

    return GestureDetector(
      onTap: () {
        context.read<MemoriceCubit>().tapCard(memorice);
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: memorice.currentColor(),
          image: memorice.showImage()
              ? DecorationImage(
                  image: AssetImage(memorice.image),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: memorice.showImage()
            ? null
            : FlutterLogo(
                size: 16,
              ),
      ),
    );
  }
}
