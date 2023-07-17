import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../core/resources/image_manager.dart';
import '../../../../../core/resources/theme_manager.dart';
import '../../../domain/models/home_models.dart';
import '../../details_item/view/details_item_view.dart';
import '../view_model/home_viewmodel.dart';

class SearchPage extends SearchDelegate {
  HomeViewModel _homeViewModel;
  SearchPage(this._homeViewModel)
      : super(
          searchFieldStyle:
              getSemiBoldStyle(16, ColorManager.white, FontsConstants.cairo),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
        );
  @override
  ThemeData appBarTheme(BuildContext context) {
    return getAppThemeData();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          _homeViewModel.search(query.toString());
          showResults(context);
        },
      ),
      const SizedBox(
        width: 8,
      ),
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = '';
        },
      ),
      const SizedBox(
        width: 16,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: StreamBuilder<List<Product>>(
            stream: _homeViewModel.searchOutputs,
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data?.length != 0) {
                return ListView.builder(
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
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: SizedBox(
                                height: 100,
                                width: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Hero(
                                    tag: "$index",
                                    child: Image.network(
                                      "${Constants.baseUrl}${Constants.producrUrl}${snapshot.data![index].image}",
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress != null) {
                                          return SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: Lottie.asset(
                                                  LottieManager.loading));
                                        } else {
                                          return child;
                                        }
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
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
                                    "${snapshot.data?[index].description.substring(0, snapshot.data![index].description.length > 60 ? 60 : snapshot.data![index].description.length)}...",
                                    style: getRegularStyle(
                                        10,
                                        ColorManager.grey1,
                                        FontsConstants.cairo),
                                  ),
                                  Text(
                                    "${snapshot.data?[index].price}da",
                                    style: getBoldStyle(
                                        18,
                                        ColorManager.primary,
                                        FontsConstants.cairo),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(
                      "لا يوجد نتائج للبحث",
                      style: getBoldStyle(
                          20, ColorManager.primary, FontsConstants.cairo),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(ImageManager.logo),
          ),
          Text(
            "مطعم اوفردوز",
            style: getBoldStyle(26, ColorManager.primary, FontsConstants.cairo),
          ),
        ],
      ),
    );
  }
}
