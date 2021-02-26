import 'dart:math';

class Memorice {
  final String image;
  final int id;
  bool _discovered;

  Memorice({this.id, this.image, bool discovered = false})
      : _discovered = discovered;

  // ignore: unnecessary_getters_setters
  set discovered(bool discovered) => _discovered = discovered;
  // ignore: unnecessary_getters_setters
  bool get discovered => _discovered;

  @override
  String toString() {
    return '[id:$id, discovered: $_discovered]';
  }
}

class MemoriceBuilder {
  MemoriceBuilder._();

  static List<Memorice> builder(int length) {
    final data = List<Memorice>.generate(
      length,
      (index) {
        int id = index;
        if (index + 1 > length ~/ 2) {
          id = index - length ~/ 2;
        }

        return Memorice(id: id, image: 'images/$id.png');
      },
    );

    final List<Memorice> memorice = [];
    for (var i = length - 1; i >= 0; i--) {
      int randomId = 0;
      if (i > 0) {
        randomId = Random().nextInt(i);
      }
      memorice.add(data[randomId]);

      data.remove(data[randomId]);
    }
    return memorice;
  }
}
