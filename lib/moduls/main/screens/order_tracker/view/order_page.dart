import 'package:flutter/material.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';

class OrderPageScreen extends StatefulWidget {
  String status;
  OrderPageScreen({super.key, required this.status});

  @override
  State<OrderPageScreen> createState() => _OrderPageScreenState(status);
}

class _OrderPageScreenState extends State<OrderPageScreen> {
  String status;
  _OrderPageScreenState(this.status);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            "تتبع الطلب",
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
                SizedBox(
                  height: 180,
                  width: 200,
                  child: Image.asset(ImageManager.delivery),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  status == 'delivered'
                      ? 'تم توصيل الطعام بنجاح . شهية طيبة مع اوفردوز'
                      : "كن مستعد ,سيصل طعامك في اي لحضة الان",
                  style: getRegularStyle(
                      13, ColorManager.grey1, FontsConstants.cairo),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      status == 'delivered' ? '0' : "0 - 30",
                      style: getBoldStyle(20, Colors.black, ''),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "دقيقة",
                      style: getMediumStyle(
                          14, ColorManager.primary, FontsConstants.cairo),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تم الطلب",
                      style: getSemiBoldStyle(
                          14, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: status == 'confirmed' ||
                              status == 'processing' ||
                              status == 'out_for_delivery' ||
                              status == 'delivered'
                          ? ColorManager.primary
                          : ColorManager.grey1,
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
                Row(
                  children: [
                    status == 'confirmed' ||
                            status == 'processing' ||
                            status == 'out_for_delivery' ||
                            status == 'delivered'
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.grey1, width: 2),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تم قبول الطلب",
                      style: getSemiBoldStyle(
                          14, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: status == 'processing' ||
                              status == 'out_for_delivery' ||
                              status == 'delivered'
                          ? ColorManager.primary
                          : ColorManager.grey1,
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
                Row(
                  children: [
                    status == 'processing' ||
                            status == 'out_for_delivery' ||
                            status == 'delivered'
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.grey1, width: 2),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تحضير الطعام",
                      style: getSemiBoldStyle(
                          14, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color:
                          status == 'out_for_delivery' || status == 'delivered'
                              ? ColorManager.primary
                              : ColorManager.grey1,
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
                Row(
                  children: [
                    status == 'out_for_delivery' || status == 'delivered'
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.grey1, width: 2),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "الطعام في الطريق",
                      style: getSemiBoldStyle(
                          14, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: status == 'delivered'
                          ? ColorManager.primary
                          : ColorManager.grey1,
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
                Row(
                  children: [
                    status == 'delivered'
                        ? Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.grey1, width: 2),
                                borderRadius: BorderRadius.circular(100)),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "توصيل الطعام",
                      style: getSemiBoldStyle(
                          14, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                getCustomButton(context, 'العودة للصفحة الرئيسية', () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.mainScreen, (route) => false);
                }),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
