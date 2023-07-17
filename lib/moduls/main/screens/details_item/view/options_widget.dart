import 'package:flutter/material.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/screens/details_item/view_model/details_viewmodel.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class ItemOptions extends StatefulWidget {
  ItemOptions(
      {super.key, required this.variation, required this.detailsViewModel});
  Variation variation;
  DetailsViewModel detailsViewModel;
  @override
  State<ItemOptions> createState() =>
      _ItemOptionsState(variation, detailsViewModel);
}

class _ItemOptionsState extends State<ItemOptions> {
  Variation variation;

  _ItemOptionsState(this.variation, this.detailsViewModel);
  DetailsViewModel detailsViewModel;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  bool? _isChosed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 201, 201, 201),
                offset: Offset(0, 0),
                blurRadius: 8)
          ],
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6))),
      child: Row(
        children: [
          const SizedBox(
            width: 6,
          ),
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                        width: 0.2, color: Color.fromARGB(255, 199, 199, 199)),
                  )),
              value: _isChosed,
              onChanged: (val) {
                val == false
                    ? detailsViewModel.addToPrice(
                        variation.id, variation.price, variation.name, '-')
                    : detailsViewModel.addToPrice(
                        variation.id, variation.price, variation.name, '+');

                setState(() {
                  _isChosed = val;
                });
              },
              checkColor: ColorManager.white,
              activeColor: ColorManager.primary,
            ),
          ),
          Text(
            variation.name.toString(),
            style: getSemiBoldStyle(
                16, ColorManager.blackBlue, FontsConstants.cairo),
          ),
          const Expanded(child: SizedBox()),
          Text(
            "${variation.price.toString()}da",
            style: getBoldStyle(16, ColorManager.primary, FontsConstants.cairo),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
