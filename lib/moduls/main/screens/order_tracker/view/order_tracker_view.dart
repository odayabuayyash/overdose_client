import 'package:flutter/material.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';
import 'package:overdose/moduls/main/screens/order_tracker/view/order_page.dart';
import 'package:overdose/moduls/main/screens/order_tracker/viewmodel/order_tracker_viewmodel.dart';

class OrderTrackerScreen extends StatefulWidget {
  int loc;
  OrderTrackerScreen({super.key, required this.loc});

  @override
  State<OrderTrackerScreen> createState() => _OrderTrackerScreenState(loc);
}

class _OrderTrackerScreenState extends State<OrderTrackerScreen> {
  int loc;
  _OrderTrackerScreenState(this.loc);
  final OrderTrackerViewModel _trackerViewModel =
      inectance<OrderTrackerViewModel>();
  @override
  void initState() {
    _trackerViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  loc == 1
                      ? SizedBox(
                          height: 35,
                          width: 25,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 26,
                                color: ColorManager.blackBlue,
                              )),
                        )
                      : const SizedBox(
                          height: 35,
                          width: 25,
                        ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "تتبع الطلب",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const SizedBox(
                    height: 35,
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<FlowState>(
                stream: _trackerViewModel.flowStateOutput,
                builder: (context, snapshot) =>
                    snapshot.data?.getScreenWidget(_getContent(), context, () {
                      _trackerViewModel.getOrderData();
                    }) ??
                    _getContent()),
          ),
        ],
      ),
    );
  }

  Widget _getContent() {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<OrdersData>(
            stream: _trackerViewModel.orderOutput,
            builder: (context, snapshot) {
              if (snapshot.data?.orders != null &&
                  snapshot.data?.orders?.length != 0) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Text(
                          'ادارة الطلبات',
                          style: getRegularStyle(
                              14, ColorManager.blackBlue, FontsConstants.cairo),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: ColorManager.primary,
                    ),
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.orders?.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, bottom: 10),
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: ColorManager.grey2,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: ColorManager.grey1,
                                              blurRadius: 5,
                                              offset: Offset(2, 3))
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 10),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 110,
                                            width: 130,
                                            child: Image.asset(
                                              'assets/images/f.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        'رقم التعريف الخاص بالطلب:',
                                                        style: getRegularStyle(
                                                          10,
                                                          Colors.black,
                                                          FontsConstants.cairo,
                                                        )),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                        '${snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].id}',
                                                        style: getBoldStyle(
                                                          12,
                                                          Colors.black,
                                                          FontsConstants.cairo,
                                                        )),
                                                  ],
                                                ),
                                                const Expanded(
                                                    child: SizedBox()),
                                                Row(
                                                  children: [
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 15,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: snapshot
                                                                            .data
                                                                            ?.orders?[snapshot.data!.orders!.length -
                                                                                1 -
                                                                                index]
                                                                            .statusOrder ==
                                                                        'confirmed'
                                                                    ? const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        238,
                                                                        161,
                                                                        88)
                                                                    : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                            'processing'
                                                                        ? ColorManager
                                                                            .primary
                                                                        : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                                'out_for_delivery'
                                                                            ? ColorManager.primary
                                                                            : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder == 'delivered'
                                                                                ? Colors.green
                                                                                : const Color.fromARGB(255, 211, 87, 71),
                                                                borderRadius: BorderRadius.circular(100)),
                                                        child: const Icon(
                                                          Icons.done,
                                                          color: ColorManager
                                                              .white,
                                                          size: 12,
                                                        )),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                        snapshot
                                                                    .data
                                                                    ?.orders?[snapshot
                                                                            .data!
                                                                            .orders!
                                                                            .length -
                                                                        1 -
                                                                        index]
                                                                    .statusOrder ==
                                                                'pending'
                                                            ? 'قيد الانتظار'
                                                            : snapshot
                                                                        .data
                                                                        ?.orders?[snapshot.data!.orders!.length -
                                                                            1 -
                                                                            index]
                                                                        .statusOrder ==
                                                                    'confirmed'
                                                                ? 'تم قبول الطلب'
                                                                : snapshot
                                                                            .data
                                                                            ?.orders?[snapshot.data!.orders!.length -
                                                                                1 -
                                                                                index]
                                                                            .statusOrder ==
                                                                        'processing'
                                                                    ? 'تحضير الطعام'
                                                                    : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                            'out_for_delivery'
                                                                        ? 'الطعام في الطريق'
                                                                        : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                                'delivered'
                                                                            ? 'تم التوصيل'
                                                                            : 'تم الطلب',
                                                        style: getSemiBoldStyle(
                                                          10,
                                                          snapshot
                                                                      .data
                                                                      ?.orders?[snapshot
                                                                              .data!
                                                                              .orders!
                                                                              .length -
                                                                          1 -
                                                                          index]
                                                                      .statusOrder ==
                                                                  'confirmed'
                                                              ? const Color.fromARGB(
                                                                  255,
                                                                  238,
                                                                  161,
                                                                  88)
                                                              : snapshot
                                                                          .data
                                                                          ?.orders?[snapshot.data!.orders!.length -
                                                                              1 -
                                                                              index]
                                                                          .statusOrder ==
                                                                      'processing'
                                                                  ? ColorManager
                                                                      .primary
                                                                  : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                          'out_for_delivery'
                                                                      ? ColorManager
                                                                          .primary
                                                                      : snapshot.data?.orders?[snapshot.data!.orders!.length - 1 - index].statusOrder ==
                                                                              'delivered'
                                                                          ? Colors
                                                                              .green
                                                                          : const Color.fromARGB(255, 211, 87, 71),
                                                          FontsConstants.cairo,
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                SizedBox(
                                                    height: 40,
                                                    child: getCustomButton(
                                                        context, 'تتبع الطلب',
                                                        () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (_) => OrderPageScreen(
                                                              status: snapshot
                                                                      .data
                                                                      ?.orders?[snapshot
                                                                              .data!
                                                                              .orders!
                                                                              .length -
                                                                          1 -
                                                                          index]
                                                                      .statusOrder ??
                                                                  '')));
                                                    })),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )))
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'لا يوجد طلبيات',
                    style: getSemiBoldStyle(
                        22, ColorManager.blackBlue, FontsConstants.cairo),
                  ),
                );
              }
            }));
  }
}
