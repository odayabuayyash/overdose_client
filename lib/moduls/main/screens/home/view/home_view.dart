import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/app/constants.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/card/view/card_view.dart';
import 'package:overdose/moduls/main/screens/details_item/view/details_item_view.dart';
import 'package:overdose/moduls/main/screens/home/view/search_page.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';

import '../../../domain/models/home_models.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = inectance<HomeViewModel>();
  String image1 = "assets/test/gettyimages-981782084-1024x1024.jpg";
  String image2 = 'assets/test/istock000044051102large.jpg';
  String image3 = 'assets/test/pexels-chan-walrus-958545.jpg';

  @override
  void initState() {
    _homeViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // ------------------------ custom app bar ----------------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
          child: Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  height: 45,
                  width: 69,
                  child: SvgPicture.asset(
                    "assets/images/whiteLogo.svg",
                    color: Colors.white,
                    fit: BoxFit.cover,
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchPage(_homeViewModel));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: ColorManager.white,
                      size: 34,
                    )),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CardScreen(
                              home: _homeViewModel,
                            )));
                  },
                  child: SizedBox(
                    height: 43,
                    width: 40,
                    child: Stack(
                      children: [
                        Positioned(
                            right: 4,
                            bottom: 4,
                            child: SvgPicture.asset(
                              "assets/images/card.svg",
                              color: Colors.white,
                              height: 43,
                              width: 40,
                            )),
                        StreamBuilder<int>(
                          stream: _homeViewModel.counterCardOutputs,
                          builder: (context, snapshot) => Positioned(
                              top: 0,
                              left: 0,
                              child: snapshot.data != 0
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text('${snapshot.data}',
                                          style: getSemiBoldStyle(
                                            10,
                                            ColorManager.white,
                                            FontsConstants.cairo,
                                          )))
                                  : const SizedBox()),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
      ),
// ----------------------------------------------------------
      body: StreamBuilder<FlowState>(
          stream: _homeViewModel.flowStateOutput,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(_getContent(), context, () {
                _homeViewModel.getHomeData();
              }) ??
              _getContent()),
    );
  }

  Widget _getContent() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---------------------------- location widget --------------------------
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Text("التوصيل إلى",
                      style: getRegularStyle(
                        12,
                        ColorManager.greyBlue,
                        FontsConstants.cairo,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: StreamBuilder<bool>(
                  stream: _homeViewModel.showLocationOutputs,
                  builder: (context, snapshot) => SizedBox(
                    height: 28,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text("الموقع الحالي",
                            style: getRegularStyle(
                              16,
                              ColorManager.blackBlue,
                              FontsConstants.cairo,
                            )),
                        const Expanded(child: SizedBox()),
                        IconButton(
                            onPressed: () {
                              _homeViewModel
                                  .showLocation(snapshot.data ?? false);
                            },
                            icon: snapshot.data == true
                                ? const Icon(
                                    Icons.expand_less,
                                    color: ColorManager.primary,
                                    size: 35,
                                  )
                                : const Icon(
                                    Icons.expand_more,
                                    color: ColorManager.primary,
                                    size: 35,
                                  )),
                        const Expanded(child: SizedBox()),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
              StreamBuilder<bool>(
                stream: _homeViewModel.showLocationOutputs,
                builder: (context, snapshot) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: snapshot.data == true ? 80 : 0,
                  margin: const EdgeInsets.only(
                      left: 4, right: 4, top: 8, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: ColorManager.primary),
                    borderRadius: BorderRadius.circular(6),
                  ),
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
                          _homeViewModel.goToPageLocation(
                              context, _homeViewModel);
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
              ),

              // --------------------------------------------------------------------
              // ---------------------- caroudel widget -----------------------------
              Container(
                width: double.infinity,
                height: 200,
                color: ColorManager.white,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                  ),
                  items: _homeViewModel.banners?.map((e) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8, left: 8),
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return SizedBox(
                                      width: 80,
                                      height: 80,
                                      child:
                                          Lottie.asset(LottieManager.loading));
                                } else {
                                  return const SizedBox();
                                }
                              },
                              imageUrl: "${Constants.baseUrl}${e.image}",
                              placeholder: (context, url) =>
                                 SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Lottie.asset(
                                                    LottieManager.loading)),
                              errorWidget: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.error,
                                color: ColorManager.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              // ------------------------------------------------------------------
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 130,
                child: StreamBuilder<List<Caty>>(
                  stream: _homeViewModel.categoryOutputs,
                  builder: (context, snapshot) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        onTap: () {
                          _homeViewModel.changeCategory(
                              snapshot.data![index].id, index);
                        },
                        child: StreamBuilder(
                          stream: _homeViewModel.indexCategoryOutputs,
                          builder: (context, snap) => SizedBox(
                            height: 130,
                            width: 90,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 105,
                                  width: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Hero(
                                      tag: '${index + 1000}',
                                      child: CachedNetworkImage(
                                        
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress != null) {
                                            return SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Lottie.asset(
                                                    LottieManager.loading));
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                        imageUrl:
                                            "${Constants.baseUrl}${Constants.categoryUrl}${snapshot.data?[index].images}",
                                        placeholder: (context, url) =>
                                           SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Lottie.asset(
                                                    LottieManager.loading)),
                                        errorWidget:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.error,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "${snapshot.data?[index].title}",
                                  style: getBoldStyle(
                                      14,
                                      snap.data == index
                                          ? ColorManager.primary
                                          : ColorManager.blackBlue,
                                      FontsConstants.cairo),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //----------------------------------------------------------------------
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: StreamBuilder<List<Product>>(
                  stream: _homeViewModel.itemsOutputs,
                  builder: (context, snapshot) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 12, top: 12),
                      child: InkWell(
                        onTap: () {
                          itemDI();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DetailsItemScreen(
                                    product: snapshot.data![index],
                                    indx: index,
                                    homeViewModel: _homeViewModel,
                                  )));
                        },
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorManager.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: ColorManager.greyBlue,
                                  blurRadius: 7,
                                  offset: Offset(3, 4),
                                )
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SizedBox(
                                  height: 100,
                                  width: 130,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Hero(
                                      tag: "$index",
                                      child:   CachedNetworkImage(
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                 (context, child, loadingProgress) {
                                          if (loadingProgress != null) {
                                            return SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Lottie.asset(
                                                    LottieManager.loading));
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                              imageUrl:  "${Constants.baseUrl}${Constants.producrUrl}${snapshot.data![index].image}",
                              placeholder: (context, url) =>
                                SizedBox(
                                                width: 80,
                                                height: 80,
                                                child: Lottie.asset(
                                                    LottieManager.loading)),
                              errorWidget: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.error,
                                color: ColorManager.primary,
                              ),
                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data?[index].name}",
                                      style: getSemiBoldStyle(
                                          15,
                                          ColorManager.blackBlue,
                                          FontsConstants.cairo),
                                    ),
                                    Text(
                                      "${snapshot.data?[index].description.substring(0, snapshot.data![index].description.length >= 60 ? 60 : snapshot.data?[index].description.length)}...",
                                      style: getRegularStyle(
                                          10,
                                          ColorManager.grey1,
                                          FontsConstants.cairo),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      "${snapshot.data?[index].price}da",
                                      style: getBoldStyle(
                                          18,
                                          ColorManager.primary,
                                          FontsConstants.cairo),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
