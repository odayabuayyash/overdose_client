import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/more_screens/notifications/viewmodel/notification_viewmodel.dart';
import '../../../../../../core/resources/image_manager.dart';
import '../../../../domain/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({super.key, required this.loc});
  int loc;
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState(loc);
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationViewModel _viewModel = inectance();
  int loc;
  _NotificationsScreenState(this.loc);
  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.flowStateOutput,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(_getContent(), context, () {
                _viewModel.getNotification();
              }) ??
              _getContent()),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 30),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "البريد الوارد",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
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
          Expanded(
            child: StreamBuilder<List<Notifi>?>(
                stream: _viewModel.notificationOutput,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data?.length != 0) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var parsedDate = DateTime.parse(
                              '${snapshot.data?[snapshot.data!.length - 1 - index].created_at}');
                          return Container(
                            color: index % 2 == 0
                                ? Color.fromARGB(255, 244, 245, 245)
                                : ColorManager.white,
                            width: double.infinity,
                            height: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            borderRadius:
                                                BorderRadius.circular(200)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${snapshot.data?[snapshot.data!.length - 1 - index].title}",
                                        style: getMediumStyle(
                                            16,
                                            ColorManager.blackBlue,
                                            FontsConstants.cairo),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "${Jiffy('${snapshot.data?[snapshot.data!.length - 1 - index].created_at}').format("do MMM")}",
                                        style: getRegularStyle(
                                            12,
                                            ColorManager.grey1,
                                            FontsConstants.cairo),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "${snapshot.data?[snapshot.data!.length - 1 - index].description}",
                                      style: getMediumStyle(
                                          13,
                                          ColorManager.grey1,
                                          FontsConstants.cairo),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text('لا يوجد بيانات'),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
