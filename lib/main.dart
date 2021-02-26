import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memorice/memorice.dart';
import 'package:memorice/memorice_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MemoriceProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(constraints,
          designSize: Size(380, 760), allowFontScaling: true);
      return MaterialApp(
        title: 'Flutterice',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(
          title: 'Flutterice',
          length: 16,
        ),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.length})
      : memorice = MemoriceBuilder.builder(length),
        super(key: key);

  final String title;
  final int length;
  final List<Memorice> memorice;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _start;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 0.9.sw,
          child: Column(
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.memorice
                    .map(
                      (memorice) => MemCard(
                        memorice,
                        key: UniqueKey(),
                      ),
                    )
                    .toList(),
              ),
              // MaterialButton(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   onPressed: () {},
              //   color: Theme.of(context).primaryColor,
              //   textColor: Colors.white,
              //   child: Text(
              //     'Start',
              //   ),
              // ),
              // MaterialButton(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   onPressed: () {
              //     context.read<MemoriceProvider>().stopTimer();
              //   },
              //   color: Theme.of(context).primaryColor,
              //   textColor: Colors.white,
              //   child: Text(
              //     'Stop',
              //   ),
              // ),
              // StreamBuilder<int>(
              //   stream: startTimer(),
              //   initialData: 0,
              //   builder: (context, snapshot) => Text('Timer: ${snapshot.data}'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<int> startTimer() async* {
    int _count = 0;
    _start = true;
    while (_start) {
      _count++;
      await Future.delayed(Duration(seconds: 1));
    }
  }
}

class MemCard extends StatefulWidget {
  final Memorice memorice;
  const MemCard(this.memorice, {Key key}) : super(key: key);

  @override
  _MemCardState createState() => _MemCardState();
}

class _MemCardState extends State<MemCard> {
  bool selected;

  @override
  void initState() {
    setState(() {
      selected = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.memorice.id;
    bool wasDiscovered =
        context.watch<MemoriceProvider>().memorice.contains(id);
    final selectedKey1 = context.watch<MemoriceProvider>().selectedKey1;
    final selectedKey2 = context.watch<MemoriceProvider>().selectedKey2;
    bool isSelected = widget.key == selectedKey1 || widget.key == selectedKey2;

    return GestureDetector(
      onTap: () {
        context.read<MemoriceProvider>().select(id, widget.key);
      },
      child: Container(
        height: 0.18.sw,
        width: 0.18.sw,
        // child: isSelected || wasDiscovered
        //     ? Icon(
        //         widget.memorice.icon,
        //         size: 0.15.sw,
        //       )
        //     : null,
        decoration: BoxDecoration(
          color: wasDiscovered
              ? Colors.blue
              : isSelected
                  ? Colors.green
                  : Colors.white,
          image: isSelected || wasDiscovered
              ? DecorationImage(
                  image: AssetImage(widget.memorice.image),
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
      ),
    );
  }
}
