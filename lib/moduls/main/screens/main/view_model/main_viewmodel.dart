import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:rxdart/subjects.dart';

class MainViewModel extends BaseViewModel with MainInputs, MainOutputs {
  final StreamController _getCurrentIndex = BehaviorSubject<int>();
  PageController controller = PageController(initialPage: 2);
  int indx = 2;
  @override
  dispose() {
    _getCurrentIndex.close();
    controller.dispose();
  }

  @override
  start() {
    currentIndexInput.add(2);
  }

  @override
  Sink get currentIndexInput => _getCurrentIndex.sink;

  @override
  Stream<int> get currentIndexOutput =>
      _getCurrentIndex.stream.map((index) => index);

  @override
  jompToPage(int index) {
    currentIndexInput.add(index);
    controller.jumpToPage(index);
    indx = index;
  }
}

abstract class MainInputs {
  Sink get currentIndexInput;
  jompToPage(int index);
}

abstract class MainOutputs {
  Stream<int> get currentIndexOutput;
}
