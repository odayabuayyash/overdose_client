import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/domain/models/home_models.dart';
import 'package:overdose/moduls/main/screens/card/view/card_view.dart';
import 'package:overdose/moduls/main/screens/details_item/view/options_widget.dart';
import 'package:overdose/moduls/main/screens/details_item/view_model/details_viewmodel.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/dependency_injection.dart';

class DetailsItemScreen extends StatefulWidget {
  Product product;
  int indx;
  HomeViewModel homeViewModel;

  DetailsItemScreen({
    Key? key,
    required this.product,
    required this.indx,
    required this.homeViewModel,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<DetailsItemScreen> createState() =>
      _DetailsItemScreenState(product, indx, homeViewModel);
}

class _DetailsItemScreenState extends State<DetailsItemScreen> {
  _DetailsItemScreenState(this.product, this.indx, this.homeViewModel);
  DetailsViewModel _detailsViewModel = inectance<DetailsViewModel>();
  Product product;
  int indx;
  HomeViewModel homeViewModel;

  @override
  void initState() {
    _detailsViewModel.start();
    _detailsViewModel.addPrice(product.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10),
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black38),
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.white,
                )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: _getContent(),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 390,
              width: double.infinity,
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Hero(
                      tag: "$indx",
                      child: Image.network(
                        "${Constants.baseUrl}${Constants.producrUrl}${product.image}",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return SizedBox(
                                width: 80,
                                height: 80,
                                child: Lottie.asset(LottieManager.loading));
                          } else {
                            return child;
                          }
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.error,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: ColorManager.greyBlue,
                                  offset: Offset(0, -7))
                            ],
                            color: ColorManager.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60))),
                      ))
                ],
              ),
            ),
            Container(
              color: ColorManager.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Text(
                      "${product.name}",
                      style: getBoldStyle(
                          22, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 60, right: 60, bottom: 10),
                    child: Text(
                      "${product.price.toString()}da",
                      style: getBoldStyle(
                          32, ColorManager.primary, FontsConstants.cairo),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 4),
                    child: Text(
                      "الوصف",
                      style: getRegularStyle(
                          16, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    child: Text(
                      "${product.description}",
                      style: getRegularStyle(
                          12, ColorManager.grey1, FontsConstants.cairo),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Text(
                      "خيارات",
                      style: getRegularStyle(
                          16, ColorManager.blackBlue, FontsConstants.cairo),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: product.options.length,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 100, right: 20),
                        child: ItemOptions(
                          variation: product.options[index],
                          detailsViewModel: _detailsViewModel,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "العدد",
                            style: getBoldStyle(16, ColorManager.blackBlue,
                                FontsConstants.cairo),
                          ),
                          const Expanded(child: SizedBox()),
                          Container(
                            width: 60,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () {
                                _detailsViewModel.counterMineus(product.price);
                              },
                              child: const Icon(
                                size: 16,
                                Icons.remove,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.primary, width: 1),
                                  borderRadius: BorderRadius.circular(16)),
                              child: StreamBuilder<int>(
                                stream: _detailsViewModel.counterOutput,
                                builder: (context, snapshot) => Text(
                                  "${snapshot.data}",
                                  style: getBoldStyle(16, ColorManager.primary,
                                      FontsConstants.cairo),
                                ),
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 60,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () {
                                _detailsViewModel.counterPlus(product.price);
                              },
                              child: const Icon(
                                size: 16,
                                Icons.add,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 120,
                              decoration: const BoxDecoration(
                                  color: ColorManager.primary,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(70),
                                      bottomRight: Radius.circular(70))),
                            )),
                        Positioned(
                            top: 25,
                            right: 60,
                            bottom: 25,
                            left: 60,
                            child: Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 8,
                                        color: Colors.black26)
                                  ],
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(8))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "السعر الكلي",
                                      style: getSemiBoldStyle(
                                          14,
                                          ColorManager.blackBlue,
                                          FontsConstants.cairo),
                                    ),
                                    StreamBuilder<int>(
                                      stream:
                                          _detailsViewModel.totalPriceOutput,
                                      builder: (context, snapshot) => Text(
                                        "${snapshot.data}da",
                                        style: getBoldStyle(
                                            22,
                                            ColorManager.blackBlue,
                                            FontsConstants.cairo),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 40, right: 40),
                                      child: StreamBuilder<String>(
                                        stream:
                                            _detailsViewModel.stateButtonOutput,
                                        builder: (context, snapshot) => InkWell(
                                          onTap: snapshot.data == 'active'
                                              ? () {
                                                  _detailsViewModel.addToCartd(
                                                      context,
                                                      product.name,
                                                      double.parse(product.price
                                                          .toString()),
                                                      product.image,
                                                      product.id,
                                                      homeViewModel,
                                                      product.discount);
                                                }
                                              : snapshot.data == 'selected'
                                                  ? () {}
                                                  : null,
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: ColorManager.primary),
                                              child: snapshot.data == 'active'
                                                  ? Text(
                                                      "اضافة الى السلة",
                                                      style: getBoldStyle(
                                                          14,
                                                          ColorManager.white,
                                                          FontsConstants.cairo),
                                                    )
                                                  : snapshot.data == 'loading'
                                                      ? const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ColorManager
                                                                .white,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ))
                                                      : Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ColorManager
                                                                .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3.0),
                                                            child: Lottie.asset(
                                                                LottieManager
                                                                    .success,
                                                                repeat: false,
                                                                height: 40,
                                                                width: 40),
                                                          ))),
                                        ),
                                      ),
                                    )
                                  ]),
                            )),
                        Positioned(
                            right: 30,
                            top: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => CardScreen(
                                          home: homeViewModel,
                                        )));
                              },
                              child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 4,
                                          color: Colors.black26)
                                    ],
                                    color: ColorManager.white,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                              IconsManager.cardLight,
                                              fit: BoxFit.fitHeight),
                                        ),
                                      ),
                                      StreamBuilder<int>(
                                        stream:
                                            _detailsViewModel.lengthCardOutput,
                                        builder: (context, snapshot) =>
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: snapshot.data != 0
                                                    ? Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 18,
                                                        width: 18,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                        child: Text(
                                                            '${snapshot.data}',
                                                            style:
                                                                getSemiBoldStyle(
                                                              10,
                                                              ColorManager
                                                                  .white,
                                                              FontsConstants
                                                                  .cairo,
                                                            )))
                                                    : const SizedBox()),
                                      )
                                    ],
                                  )),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _detailsViewModel.dispose();
    super.dispose();
  }
}
