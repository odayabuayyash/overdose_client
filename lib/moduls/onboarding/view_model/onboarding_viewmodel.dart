import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:rxdart/rxdart.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingInputs, OnboardingOutputs {
  StreamController dataStream = BehaviorSubject<List<OnboardingData>>();
  StreamController indexStream = BehaviorSubject<int>();
  PageController controller1 = PageController();
  PageController controller2 = PageController();
  int index = 0;
  List<OnboardingData> data = getOnboardingData();
  @override
  dispose() {}

  @override
  start() {
    getData();
    indexInputs.add(index);
  }

  // inputs
  @override
  Sink get datainputs => dataStream.sink;
  @override
  Sink get indexInputs => indexStream.sink;
  // outputs

  @override
  Stream<List<OnboardingData>> get dataOutputs =>
      dataStream.stream.map((event) => event);
  @override
  Stream<int> get getIndex => indexStream.stream.map((event) => event);

  // methods

  @override
  getData() {
    datainputs.add(data);
  }

  @override
  onChangeIndex() {
    index = index + 1;
    controller1.jumpToPage(index);
    controller2.jumpToPage(index);
    indexInputs.add(index);
  }

  @override
  onChangePage(int index) {}
}

abstract class OnboardingInputs {
  getData();
  Sink get datainputs;
  Sink get indexInputs;

  onChangePage(int index);
  onChangeIndex();
}

abstract class OnboardingOutputs {
  Stream<List<OnboardingData>> get dataOutputs;
  Stream<int> get getIndex;
}

class OnboardingData {
  String image;
  String title;
  String subtitle;
  OnboardingData(this.image, this.title, this.subtitle);
}

List<OnboardingData> getOnboardingData() {
  List<OnboardingData> data = [
    OnboardingData(
        ImageManager.findFood, StringManager.titel1, StringManager.subTitel1),
    OnboardingData(
        ImageManager.delivery, StringManager.titel2, StringManager.subTitel2),
    OnboardingData(ImageManager.LiveTracking, StringManager.titel3,
        StringManager.subTitel3),
  ];
  return data;
}
