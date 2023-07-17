import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:overdose/moduls/main/screens/order/view/order_view.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/bases/base_viewmodel.dart';

class CardViewModel extends BaseViewModel with CardViewInputs, CardViewOutputs {
  CardViewModel(this._dataSource);
  final StreamController _itemsStream = BehaviorSubject<List<Map>?>();
  final StreamController _subTotalPriceStream = BehaviorSubject<double>();
  final StreamController _TotalPriceStream = BehaviorSubject<double>();
  final StreamController _noteStream = BehaviorSubject<String>();
  final TextEditingController myNote = TextEditingController();
  final RemoteLocalDataSource _dataSource;
  double subfinalPrice = 0;
  int deliveryPrice = 250;
  int discount = 0;
  double finalPrice = 0;
  List<dynamic> varies = [];
  List<int> add_on_ids = [];
  List<int> add_on_qtys = [];
  String note = '';
  Map<String, dynamic> myOrder = {};
  List<Map> user = [];
  int userID = 0;

  @override
  dispose() {}

  @override
  start() {
    subTotalPriceInput.add(subfinalPrice);
    totalPriceInput.add(finalPrice);
    getItemsCard();
    getUserData();
  }

  // inputs
  @override
  Sink get itemsInput => _itemsStream.sink;
  @override
  Sink get subTotalPriceInput => _subTotalPriceStream.sink;
  @override
  Sink get totalPriceInput => _TotalPriceStream.sink;
  @override
  Sink get noteInput => _noteStream.sink;

  // outputs
  @override
  Stream<List<Map>> get itemsOutput =>
      _itemsStream.stream.map((event) => event);
  @override
  Stream<double> get subTotalPriceOutput =>
      _subTotalPriceStream.stream.map((event) => event);

  @override
  Stream<double> get totalPriceOutput =>
      _TotalPriceStream.stream.map((event) => event);
  @override
  Stream<String> get noteOutput => _noteStream.stream.map((event) => event);

  //methods

  @override
  deleteFromCard(int id, HomeViewModel homeViewModel) async {
    int response = await _dataSource.onDeleteDbCards(id: id);
    getItemsCard();
    homeViewModel.getCounter();
  }

  getUserData() async {
    var response = await _dataSource.onReedDbUser();
    userID = response?[0]['id'];
  }

  getMyOrder(BuildContext context, HomeViewModel homeViewModel, String location,
      double lat, double lang, String note) async {
    myOrder = {};
    List<Map> cart = [];
    List<Map>? response = await _dataSource.onReedDbCards();
    if (response != null && response.isNotEmpty) {
      response.forEach((element) {
        add_on_ids = [];
        add_on_qtys = [];
        (json.decode(element['varies']) as List).forEach((elem) {
          add_on_ids.add(elem['id']);
          add_on_qtys.add(1);
        });
        cart.add({
          'product_id': element['item_id'],
          'quantity': element['count'],
          'add_on_ids': add_on_ids,
          'add_on_qtys': add_on_qtys,
        });
      });

      myOrder = {
        'user_id': userID,
        'address': '$location',
        'address_type': 'home',
        'longitude': lang,
        'latitude': lat,
        'order_type': 'delivry',
        'payment_method': 'cash_on_delivery',
        'cart': cart,
        'order_note': note,
        'order_amount': subfinalPrice - discount
      };
      orderDI();
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => OrderScreen(
              homeViewModel: homeViewModel,
              subPrice: subfinalPrice,
              order: myOrder,
              price: finalPrice,
              discount: discount))));
    }
  }

  @override
  getItemsCard() async {
    add_on_ids = [];
    add_on_qtys = [];
    varies = [];
    discount = 0;
    subfinalPrice = 0;
    finalPrice = 0;
    List<Map>? response = await _dataSource.onReedDbCards();
    if (response != null && response.isNotEmpty) {
      itemsInput.add(response);
      response.forEach((element) {
        varies.add(json.decode(element['varies']) ?? []);
      });
      print(varies);
      print(add_on_ids);
      print(add_on_qtys);

      for (int i = 0; i <= response.length - 1; i++) {
        subfinalPrice = subfinalPrice + response[i]['price'];
        discount = discount + int.parse(response[i]['discount'].toString());
      }
      finalPrice = subfinalPrice + deliveryPrice;

      subTotalPriceInput.add(subfinalPrice);
      totalPriceInput.add(finalPrice);
    } else {
      itemsInput.add(null);
    }
  }

  @override
  updateCard(
      {required String name,
      required int iD,
      required double price,
      required double itemPrice,
      required int index}) async {
    double finalPrice = price - itemPrice;
    varies[index].removeWhere((element) => element['type'] == name);
    String varie = json.encode(varies[index]);
    int response = await _dataSource.onUpdateCards(
        totalPrice: finalPrice, varies: varie, id: iD);
    getItemsCard();
  }

  @override
  goToOrderPage(BuildContext context) {}

  @override
  addNote() {
    note = myNote.text;
    print(note);
    noteInput.add(note);
  }
}

abstract class CardViewInputs {
  addNote();
  getItemsCard();
  deleteFromCard(int id, HomeViewModel homeViewModel);
  updateCard(
      {required String name,
      required int iD,
      required double price,
      required double itemPrice,
      required int index});
  Sink get itemsInput;
  Sink get subTotalPriceInput;
  Sink get totalPriceInput;
  Sink get noteInput;
  goToOrderPage(BuildContext context);
}

abstract class CardViewOutputs {
  Stream<List<Map>?> get itemsOutput;
  Stream<double> get subTotalPriceOutput;
  Stream<double> get totalPriceOutput;
  Stream<String> get noteOutput;
}
