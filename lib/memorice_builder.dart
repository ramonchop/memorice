import 'dart:collection';
import 'dart:math';

import 'package:memorice/memorice.dart';

class MemoriceBuilder {
  const MemoriceBuilder._();

  static LinkedHashMap<int, Memorice> builder(int length) {
    final data = <Memorice>[];
    int realId = 0;
    for (int i = 0; i < length; i++) {
      data.add(Memorice(id: realId++, image: 'images/$i.png'));
      data.add(Memorice(id: realId++, image: 'images/$i.png'));
    }

    final LinkedHashMap<int, Memorice> memorice = LinkedHashMap();
    for (var i = length * 2 - 1; i >= 0; i--) {
      int randomId = 0;
      if (i > 0) {
        randomId = Random().nextInt(i);
      }
      memorice[data[randomId].id] = data[randomId];

      data.remove(data[randomId]);
    }
    return memorice;
  }
}
