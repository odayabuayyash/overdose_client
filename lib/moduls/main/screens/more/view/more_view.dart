import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/more/widgets/custtom_row.dart';
import 'package:overdose/moduls/main/screens/more_screens/about/about_view.dart';
import 'package:overdose/moduls/main/screens/more_screens/notifications/view/notifications_view.dart';
import 'package:overdose/moduls/main/screens/order_tracker/view/order_tracker_view.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  children: [
                    Text(
                      "المزيد",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      height: 37,
                      width: 27,
                      child: SvgPicture.asset('assets/images/card.svg'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            custtomRow(() {
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
                                  borderRadius: BorderRadius.circular(10)),
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
                              style: getSemiBoldStyle(20,
                                  ColorManager.blackBlue, FontsConstants.cairo),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }, IconsManager.moneySafe, "معلومات الدفع"),
            // const SizedBox(
            //   height: 20,
            // ),
            // custtomRow(() {}, IconsManager.shopingBag, "طلباتي"),
            const SizedBox(
              height: 20,
            ),
            custtomRow(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => OrderTrackerScreen(
                        loc: 1,
                      )));
            }, IconsManager.notification, "تتبع الطلب"),
            const SizedBox(
              height: 20,
            ),
            custtomRow(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => NotificationsScreen(loc: 1))));
            }, IconsManager.mail, "البريد الوارد"),
            const SizedBox(
              height: 20,
            ),
            custtomRow(() {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutScreen()));
            }, IconsManager.aboute, "عن اوفردوز"),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
