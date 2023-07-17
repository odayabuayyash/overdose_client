import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:overdose/moduls/main/screens/order/viewmodel/order_viewmodel.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/image_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class OrderScreen extends StatefulWidget {
  HomeViewModel homeViewModel;
  double subPrice;
  double price;
  int discount;
  Map<String, dynamic> order;
  OrderScreen(
      {super.key,
      required this.homeViewModel,
      required this.subPrice,
      required this.order,
      required this.price,
      required this.discount});

  @override
  State<OrderScreen> createState() =>
      // ignore: no_logic_in_create_state
      _OrderScreenState(homeViewModel, price, discount, subPrice, order);
}

class _OrderScreenState extends State<OrderScreen> {
  String group = 'الدفع عند الاستلام';
  final HomeViewModel _homeViewModel;
  final OrderViewModel _orderViewModel = inectance<OrderViewModel>();
  double subPrice;
  double price;
  int discount;

  Map<String, dynamic> order;
  _OrderScreenState(this._homeViewModel, this.price, this.discount,
      this.subPrice, this.order);
  @override
  void initState() {
    _orderViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double finalprice = price - discount;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  children: [
                    SizedBox(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "الدفع",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                height: 20,
                width: double.infinity,
                child: Text("عنوان التسليم",
                    style: getMediumStyle(
                      14,
                      ColorManager.greyBlue,
                      FontsConstants.cairo,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(ImageManager.locationIcon)),
                      ),
                      StreamBuilder<String>(
                        stream: _homeViewModel.locationOutputs,
                        builder: (context, snapshot) => Container(
                          alignment: Alignment.centerLeft,
                          child: snapshot.data != null &&
                                  snapshot.data != '' &&
                                  snapshot.data != 'LOCATIONKEY'
                              ? Text("${snapshot.data}",
                                  style: getRegularStyle(
                                    14,
                                    ColorManager.blackBlue,
                                    FontsConstants.cairo,
                                  ))
                              : Text("لم يتم اختيار الموقع بعد",
                                  style: getRegularStyle(
                                    14,
                                    ColorManager.blackBlue,
                                    FontsConstants.cairo,
                                  )),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      _homeViewModel.goToPageLocation(context, _homeViewModel);
                    },
                    child: Text("تغيير",
                        style: getSemiBoldStyle(
                          14,
                          ColorManager.primary,
                          FontsConstants.cairo,
                        )),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 15,
              width: double.infinity,
              color: ColorManager.grey2,
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorManager.greyBlue,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 103,
                                    width: 123,
                                    decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset(
                                        ImageManager.logo,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "سيتم اضافة الدفع الالكتروني قريبا...",
                                    style: getSemiBoldStyle(
                                        20,
                                        ColorManager.blackBlue,
                                        FontsConstants.cairo),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'طريقة الدفع او السداد',
                        style: getMediumStyle(
                            14, ColorManager.greyBlue, FontsConstants.cairo),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        '+اضافة بطاقة',
                        style: getMediumStyle(
                            14, ColorManager.primary, FontsConstants.cairo),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.grey2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 10),
                  child: Row(
                    children: [
                      Radio(
                          activeColor: ColorManager.primary,
                          value: 'الدفع عند الاستلام',
                          groupValue: group,
                          onChanged: (e) {}),
                      const Expanded(child: SizedBox()),
                      Text(
                        'الدفع عند الاستلام',
                        style: getMediumStyle(
                            13, ColorManager.blackBlue, FontsConstants.cairo),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 15,
              width: double.infinity,
              color: ColorManager.grey2,
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Text(
                      "المجموع الفرعي",
                      style: getMediumStyle(
                          13, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "$subPrice da",
                      style: getBoldStyle(
                          16, ColorManager.blackBlue, FontsConstants.cairo),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Text(
                      "تكلفة التوصيل",
                      style: getMediumStyle(
                          13, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "250 da",
                      style: getBoldStyle(
                          15, ColorManager.blackBlue, FontsConstants.cairo),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Text(
                      "الخصم",
                      style: getMediumStyle(
                          13, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "-$discount da",
                      style: getBoldStyle(
                          15, ColorManager.blackBlue, FontsConstants.cairo),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 3,
                width: double.infinity,
                color: ColorManager.grey2,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    Text(
                      "المجموع",
                      style: getMediumStyle(
                          13, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "$finalprice da",
                      style: getBoldStyle(
                          16, ColorManager.blackBlue, FontsConstants.cairo),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
              width: double.infinity,
              color: ColorManager.grey2,
            ),
            Padding(
                padding: const EdgeInsets.all(30),
                child: StreamBuilder<String>(
                    stream: _orderViewModel.buttonStateOutput,
                    builder: ((context, snapshot) => snapshot.data == "active"
                        ? Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: MaterialButton(
                                  splashColor:
                                      const Color.fromARGB(255, 184, 124, 15),
                                  onPressed: () {
                                    _orderViewModel.sendOrder(
                                        order, _homeViewModel, context);
                                  },
                                  child: Text(
                                    "ارسال الطلب",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )),
                            ),
                          )
                        : const SizedBox(
                            height: 56,
                            width: 56,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 6,
                                color: ColorManager.primary,
                                backgroundColor: Colors.transparent,
                              ),
                            ))))),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
