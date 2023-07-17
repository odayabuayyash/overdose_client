import 'dart:async';

import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';
import 'package:overdose/moduls/main/domain/use_cases/use_caces.dart';
import 'package:rxdart/subjects.dart';

class OrderTrackerViewModel extends BaseViewModel
    with OrderViewTrackerInputs, OrderViewTrackerOutputs {
  final OrderDataUseCase _useCase;
  final RemoteLocalDataSource _dataSource;

  OrderTrackerViewModel(this._useCase, this._dataSource);
  final StreamController _ordersStream = BehaviorSubject<OrdersData>();
  int? id;

  @override
  dispose() {}

  @override
  start() {
    flowStateInput.add(LoadingStateFullScreen(''));
    getOrderData();
  }

  @override
  getOrderData() async {
    List<Map>? data = await _dataSource.onReedDbUser();
    id = data?[0]['id'];
    print("$id******");
    if (id != null) {
      print('not null');
      (await _useCase.excute(OrderDataInput(id!))).fold(
          (l) => {print('failleur'), flowStateInput.add(ContentState())},
          (r) => {
                print('success'),
                orderInput.add(r),
                flowStateInput.add(ContentState())
              });
    }
  }

  @override
  Sink get orderInput => _ordersStream.sink;

  @override
  Stream<OrdersData> get orderOutput =>
      _ordersStream.stream.map((event) => event);
}

abstract class OrderViewTrackerInputs {
  getOrderData();
  Sink get orderInput;
}

abstract class OrderViewTrackerOutputs {
  Stream<OrdersData> get orderOutput;
}
