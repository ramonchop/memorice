import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MemoriceProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<int> _memorice = [];
  int _selectedId;
  Key _selectedKey1;
  Key _selectedKey2;

  bool _start;
  int _count = 0;

  List<int> get memorice => _memorice;
  int get selectedId => _selectedId;
  Key get selectedKey1 => _selectedKey1;
  Key get selectedKey2 => _selectedKey2;
  int get count => _count;



  void stopTimer() {
    _start = false;
    notifyListeners();
  }

  void select(int id, Key key) async {
    if (contains(id)) return;

    if (_selectedId == null) {
      _selectedKey1 = key;
      _selectedId = id;
    } else {
      _selectedKey2 = key;
      notifyListeners();

      if (_selectedId == id && _selectedKey1 != _selectedKey2) {
        _memorice.add(id);
        if (memorice.length == 8) _start = false;
      } else {
        await Future.delayed(Duration(seconds: 1));
      }
      _selectedId = null;
      _selectedKey1 = null;
      _selectedKey2 = null;
    }
    notifyListeners();
  }

  bool contains(int id) => _memorice != null && _memorice.contains(id);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<int>>('memorice', _memorice));
  }
}
