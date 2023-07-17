import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/moduls/main/domain/use_cases/use_caces.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/common/state_rendrer/state_rendrer_impl.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class OrderViewModel extends BaseViewModel with OrderInput, OrderOutput {
  OrderUseCace _orderUseCace;
  OrderViewModel(this._orderUseCace);
  final StreamController _buttonStateStream = BehaviorSubject<String>();

  @override
  dispose() {}

  @override
  start() {
    buttonStateInput.add('active');
  }

  @override
  sendOrder(Map<String, dynamic> ord, HomeViewModel homeViewModel,
      BuildContext context) async {
    if (homeViewModel.location != null &&
        homeViewModel.location != '' &&
        homeViewModel.langi != null &&
        homeViewModel.lati != null) {
      buttonStateInput.add('loading');
      (await _orderUseCace.excute(OrderInputs(ord))).fold(
          (l) => {
                dimissDialog(context),
                showToast("حدث خطا في ارسال الطلب . يرجى اعادة المحاولة لاحقا",
                    duration: const Duration(seconds: 5),
                    context: context,
                    backgroundColor: ColorManager.reed,
                    textStyle: getSemiBoldStyle(
                        14, ColorManager.white, FontsConstants.cairo)),
                buttonStateInput.add('active')
              },
          (r) => {
                buttonStateInput.add('active'),
                homeViewModel.deleteAllCards(context)
              });
    } else {
      dimissDialog(context);
      showToast("يرجى تحديد موقعك قبل ارسال الطلب",
          duration: const Duration(seconds: 5),
          context: context,
          backgroundColor: ColorManager.reed,
          textStyle:
              getSemiBoldStyle(14, ColorManager.white, FontsConstants.cairo));
    }
  }

  @override
  Sink get buttonStateInput => _buttonStateStream.sink;

  @override
  Stream<String> get buttonStateOutput =>
      _buttonStateStream.stream.map((event) => event);
}

abstract class OrderInput {
  sendOrder(Map<String, dynamic> ord, HomeViewModel homeViewModel,
      BuildContext context);
  Sink get buttonStateInput;
}

abstract class OrderOutput {
  Stream<String> get buttonStateOutput;
}
