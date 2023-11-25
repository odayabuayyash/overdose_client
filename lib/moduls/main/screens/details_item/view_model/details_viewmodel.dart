import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/app/shared_preferences.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:rxdart/subjects.dart';

class DetailsViewModel extends BaseViewModel with DetailsInpts, DetailsOutpts {
  final StreamController _counterStream = BehaviorSubject<int>();
  final StreamController _totalPriceStream = BehaviorSubject<int>();
  final StreamController _stateButtonStream = BehaviorSubject<String>();
  final StreamController _lengthCardStream = BehaviorSubject<int>();
  final RemoteLocalDataSource _dataSource;
  DetailsViewModel(this._dataSource);

  final AppPreferences _preferences = inectance<AppPreferences>();

  int totalPrice = 0;
  int counter = 1;
  int cardLength = 0;
  List<Map> myVariation = [];

  bool? isLogin;

  @override
  dispose() {
    inectance.unregister<DetailsViewModel>();
  }

  @override
  start() {
    getCardLength();
    counterInput.add(counter);
    stateButtonInput.add('active');
  }

  // inputs
  @override
  Sink get counterInput => _counterStream.sink;
  @override
  Sink get totalPriceInput => _totalPriceStream.sink;
  @override
  Sink get stateButtonInput => _stateButtonStream.sink;
  @override
  Sink get lengthCardInput => _lengthCardStream.sink;

  // outputs

  @override
  Stream<int> get counterOutput => _counterStream.stream.map((event) => event);
  @override
  Stream<int> get totalPriceOutput =>
      _totalPriceStream.stream.map((event) => event);

  @override
  Stream<String> get stateButtonOutput =>
      _stateButtonStream.stream.map((event) => event);
  @override
  Stream<int> get lengthCardOutput =>
      _lengthCardStream.stream.map((event) => event);

  // methods
  @override
  addToPrice(int id, int price, String title, String type) {
    if (type == "-") {
      totalPrice = totalPrice - price;
      myVariation.removeWhere((element) => element['type'] == title);
      print(myVariation.toString());
      totalPriceInput.add(totalPrice);
    } else if (type == "+") {
      totalPrice = totalPrice + price;
      myVariation.add(
          {'id': id, 'type': title, 'price': double.parse(price.toString())});
      print(myVariation.toString());
      totalPriceInput.add(totalPrice);
    }
  }

  @override
  addPrice(int price) {
    totalPrice = price;
    totalPriceInput.add(totalPrice);
  }

  @override
  counterMineus(int price) {
    if (counter > 1) {
      counter--;
      counterInput.add(counter);
      totalPrice = totalPrice - price;
      totalPriceInput.add(totalPrice);
    }
  }

  @override
  counterPlus(int price) {
    if (counter < 99) {
      counter++;
      counterInput.add(counter);
      totalPrice = totalPrice + price;
      totalPriceInput.add(totalPrice);
    }
  }

  @override
  addToCartd(BuildContext context, String title, double subPrice, String image,
      int item_id, HomeViewModel homeViewModel, int discount) async {
    isLogin = _preferences.getIsLogin() ?? false;
    if (isLogin != null && isLogin == true) {
      stateButtonInput.add('loading');
      String varies = json.encode(myVariation);

      Timer(
        Duration(seconds: 3),
        () async {
          int response = await _dataSource.onInsertCards(
              title: title,
              subPrice: subPrice * counter,
              totalPrice: double.parse(totalPrice.toString()),
              count: counter,
              varies: varies,
              item_id: item_id,
              discount: discount * counter);
          if (response > 0) {
            showToast('تمت الاضافة الى السلة',
                context: context,
                fullWidth: true,
                position: StyledToastPosition.top,
                textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
                duration: const Duration(seconds: 4),
                animDuration: const Duration(milliseconds: 200),
                backgroundColor: Colors.green);
            stateButtonInput.add('selected');
            getCardLength();
            homeViewModel.getCounter();
          } else if (response == 0) {
            stateButtonInput.add('active');
            showToast('حدث خطا في اضافة المقتنيات الى السلة',
                context: context,
                position: StyledToastPosition.top,
                duration: const Duration(seconds: 4),
                animDuration: const Duration(milliseconds: 200),
                textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
                backgroundColor: ColorManager.reed);
          }
        },
      );
    } else {
      showToast('يجب تسجيل الدخول لمتابعة العملية',
          context: context,
          position: StyledToastPosition.top,
          duration: const Duration(seconds: 4),
          animDuration: const Duration(milliseconds: 200),
          textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
          backgroundColor: ColorManager.reed);
    }
  }

  getCardLength() async {
    var response = await _dataSource.onReedDbCards();
    cardLength = response?.length ?? 0;
    print(cardLength);
    lengthCardInput.add(cardLength);
  }
}

abstract class DetailsInpts {
  addPrice(int price);
  Sink get counterInput;
  Sink get totalPriceInput;
  Sink get lengthCardInput;
  Sink get stateButtonInput;
  addToPrice(int id, int price, String title, String type);
  counterPlus(int price);
  counterMineus(int price);
  addToCartd(BuildContext context, String title, double subPrice, String image,
      int item_id, HomeViewModel homeViewModel, int discount);
}

abstract class DetailsOutpts {
  Stream<int> get counterOutput;
  Stream<int> get totalPriceOutput;
  Stream<String> get stateButtonOutput;
  Stream<int> get lengthCardOutput;
}
