import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/app/constants.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/card/viewmodel/card_viewmodel.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:sqflite/utils/utils.dart';

import '../../../../../core/local_data/remote_local_data.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/image_manager.dart';

class CardScreen extends StatefulWidget {
  CardScreen({super.key, required this.home});
  HomeViewModel home;
  @override
  State<CardScreen> createState() => _CardScreenState(home);
}

class _CardScreenState extends State<CardScreen> {
  final CardViewModel _cardViewModel =
      CardViewModel(inectance<RemoteLocalDataSource>());
  HomeViewModel _homeViewModel;
  _CardScreenState(this._homeViewModel);

  @override
  void initState() {
    _cardViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
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
                        "طلبي",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Map>?>(
                  stream: _cardViewModel.itemsOutput,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          // shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            int rating = random.nextInt(200);
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, bottom: 4),
                                  child: Dismissible(
                                    background: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: Colors.red,
                                      child: Row(
                                        children: const [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          Expanded(child: SizedBox()),
                                          Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                    key: ValueKey(snapshot.data?[index]),
                                    onDismissed: (d) {
                                      if (d == DismissDirection.endToStart ||
                                          d == DismissDirection.startToEnd) {
                                        _cardViewModel.deleteFromCard(
                                            snapshot.data?[index]["id"],
                                            _homeViewModel);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 248, 244, 244),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: SizedBox(
                                                    width: 80,
                                                    height: 80,
                                                    child: Image.asset(
                                                        'assets/images/f.png'))),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'X${snapshot.data?[index]["count"]} ${snapshot.data?[index]["title"]}',
                                                          style: getMediumStyle(
                                                            18,
                                                            ColorManager.grey1,
                                                            FontsConstants
                                                                .cairo,
                                                          )),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '5',
                                                            style:
                                                                getSemiBoldStyle(
                                                                    16,
                                                                    ColorManager
                                                                        .primary,
                                                                    ''),
                                                          ),
                                                          const Icon(
                                                            Icons.star,
                                                            color: ColorManager
                                                                .primary,
                                                            size: 18,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            '($rating تقييم)',
                                                            style:
                                                                getSemiBoldStyle(
                                                                    10,
                                                                    ColorManager
                                                                        .grey1,
                                                                    ''),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  Text(
                                                      '${snapshot.data?[index]["subPrice"].toInt()} da',
                                                      style: getBoldStyle(
                                                        18,
                                                        ColorManager.blackBlue,
                                                        FontsConstants.cairo,
                                                      )),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _cardViewModel.varies[index].length,
                                  itemBuilder: (context, e) {
                                    return Column(
                                      children: [
                                        Dismissible(
                                          background: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.red,
                                            child: Row(
                                              children: const [
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Icon(
                                                  Icons.delete,
                                                  size: 22,
                                                  color: Colors.white,
                                                ),
                                                Expanded(child: SizedBox()),
                                                Icon(
                                                  Icons.delete,
                                                  size: 22,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                              ],
                                            ),
                                          ),
                                          key: ValueKey(
                                              _cardViewModel.varies[index]),
                                          onDismissed: (d) {
                                            if (d ==
                                                    DismissDirection
                                                        .startToEnd ||
                                                d ==
                                                    DismissDirection
                                                        .endToStart) {
                                              _cardViewModel.updateCard(
                                                  name: _cardViewModel
                                                      .varies[index][e]['type'],
                                                  iD: snapshot.data?[index]
                                                      ["id"],
                                                  price: snapshot.data?[index]
                                                      ["price"],
                                                  itemPrice: double.parse(
                                                      _cardViewModel
                                                          .varies[index][e]
                                                              ['price']
                                                          .toString()),
                                                  index: index);
                                            }
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            color: ColorManager.grey2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                  Text(
                                                    'X1 ${_cardViewModel.varies[index][e]['type']}',
                                                    style: getRegularStyle(
                                                        16,
                                                        ColorManager.grey1,
                                                        FontsConstants.cairo),
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  Text(
                                                    '${_cardViewModel.varies[index][e]['price']} da',
                                                    style: getBoldStyle(
                                                        18,
                                                        ColorManager.blackBlue,
                                                        FontsConstants.cairo),
                                                  ),
                                                  const SizedBox(
                                                    width: 16,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          color: ColorManager.white,
                                          height: 1,
                                        )
                                      ],
                                    );
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      return SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child:
                                    Image.asset(ImageManager.shoppingCardEmpty),
                              ),
                              Text(
                                "لا يوجد طلبات",
                                style: getSemiBoldStyle(22,
                                    ColorManager.primary, FontsConstants.cairo),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            ),
            StreamBuilder<List<Map>?>(
              stream: _cardViewModel.itemsOutput,
              builder: (context, snapshot) => snapshot.data != null
                  ? Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Divider(
                              height: 1,
                              color: ColorManager.greyBlue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: SizedBox(
                              height: 50,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        height: 250,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            border: Border.all(
                                                color: ColorManager.primary),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "اضف ملاحضة",
                                                style: getSemiBoldStyle(
                                                    18,
                                                    ColorManager.blackBlue,
                                                    FontsConstants.cairo),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                  height: 120,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager.grey2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    child: TextFormField(
                                                      maxLines: 10,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textAlign:
                                                          TextAlign.right,
                                                      controller:
                                                          _cardViewModel.myNote,
                                                      style: getSemiBoldStyle(
                                                          16,
                                                          ColorManager.primary,
                                                          FontsConstants.cairo),
                                                      decoration: InputDecoration(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight: 60,
                                                                  minHeight:
                                                                      60),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 12),
                                                          errorStyle:
                                                              getRegularStyle(
                                                                  10,
                                                                  ColorManager
                                                                      .reed,
                                                                  FontsConstants
                                                                      .cairo),
                                                          hintText:
                                                              "اضف ملاحضة",
                                                          border:
                                                              InputBorder.none,
                                                          hintStyle:
                                                              getSemiBoldStyle(
                                                                  14,
                                                                  ColorManager
                                                                      .greyBlue,
                                                                  FontsConstants
                                                                      .cairo)),
                                                    ),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 60,
                                                    right: 60,
                                                    top: 16),
                                                child: SizedBox(
                                                  height: 40,
                                                  child: getCustomButton(
                                                      context, "حفظ الملاحضة",
                                                      () {
                                                    _cardViewModel.addNote();
                                                    Navigator.of(context).pop();
                                                  }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'تعليمات التوصيل',
                                      style: getBoldStyle(
                                          16,
                                          ColorManager.blackBlue,
                                          FontsConstants.cairo),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      'تعليمات التوصيل+',
                                      style: getBoldStyle(
                                          16,
                                          ColorManager.primary,
                                          FontsConstants.cairo),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<String>(
                              stream: _cardViewModel.noteOutput,
                              builder: (context, snapshot) {
                                if (snapshot.data != null &&
                                    snapshot.data != '') {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorManager.grey2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, left: 8),
                                        child: Text(
                                          "${snapshot.data}",
                                          style: getRegularStyle(
                                              10, ColorManager.grey1, ""),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }),
                          const Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Divider(
                              height: 1,
                              color: ColorManager.greyBlue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  Text(
                                    'المجموع الفرعي',
                                    style: getBoldStyle(
                                        18,
                                        ColorManager.blackBlue,
                                        FontsConstants.cairo),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  StreamBuilder<double>(
                                    stream: _cardViewModel.subTotalPriceOutput,
                                    builder: (context, snapshot) => Text(
                                      '${snapshot.data?.toInt()}da',
                                      style: getBoldStyle(
                                          20,
                                          ColorManager.primary,
                                          FontsConstants.cairo),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Divider(
                              height: 1,
                              color: ColorManager.greyBlue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  Text(
                                    'تكلفة التوصيل',
                                    style: getSemiBoldStyle(
                                        16,
                                        ColorManager.blackBlue,
                                        FontsConstants.cairo),
                                  ),
                                  const Expanded(
                                      child: SizedBox(
                                    height: 8,
                                  )),
                                  Text(
                                    '250 da',
                                    style: getSemiBoldStyle(
                                        18,
                                        ColorManager.primary,
                                        FontsConstants.cairo),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Divider(
                              height: 2,
                              color: ColorManager.greyBlue,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  Text(
                                    'المجموع',
                                    style: getBoldStyle(
                                        18,
                                        ColorManager.blackBlue,
                                        FontsConstants.cairo),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  StreamBuilder<double>(
                                    stream: _cardViewModel.totalPriceOutput,
                                    builder: (context, snapshot) => Text(
                                      '${snapshot.data?.toInt()}da',
                                      style: getBoldStyle(
                                          25,
                                          ColorManager.primary,
                                          FontsConstants.cairo),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Divider(
                              height: 2,
                              color: ColorManager.greyBlue,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
            StreamBuilder<List<Map>?>(
              stream: _cardViewModel.itemsOutput,
              builder: (context, snapshot) => snapshot.data != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: 30, left: 30, top: 16, bottom: 30),
                      child: getCustomButton(context, 'الدفع', () {
                        _cardViewModel.getMyOrder(
                            context,
                            _homeViewModel,
                            _homeViewModel.location,
                            _homeViewModel.lati ?? 0,
                            _homeViewModel.langi ?? 0,
                            _cardViewModel.note);
                      }),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
