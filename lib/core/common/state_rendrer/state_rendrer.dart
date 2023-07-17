import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/core/resources/values_manager.dart';

enum StateRendrerType {
  // pop up states
  loadinPopUp,
  errorPopUp,

// full screen states
  loadingFullScreen,
  errorFullScreen,

// contrent state

  content
}

class StateRendrer extends StatelessWidget {
  String message;
  Function tryFunction;
  StateRendrerType stateRendrerType;
  StateRendrer({
    Key? key,
    this.message = "",
    required this.tryFunction,
    required this.stateRendrerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateRendrer(context);
  }

  Widget _getStateRendrer(BuildContext context) {
    switch (stateRendrerType) {
      case StateRendrerType.loadinPopUp:
        return _getDialogLoading([
          _getImage(LottieManager.loading),
        ]);

      case StateRendrerType.errorPopUp:
        return _getDialog([
          _getImage(LottieManager.error),
          _getText(message),
          const Expanded(
            child: SizedBox(),
          ),
          _getButton(context, "اعد المحاولة"),
          const SizedBox(
            height: 16,
          ),
        ]);

      case StateRendrerType.loadingFullScreen:
        return _getColumn([Center(child: _getImage(LottieManager.loading))]);
      case StateRendrerType.errorFullScreen:
        return Padding(
          padding: const EdgeInsets.only(right: 40, left: 40),
          child: _getColumn([
            _getImage(LottieManager.error),
            _getText(message),
            const SizedBox(
              height: 8,
            ),
            _getButton(context, "اعد المحاولة"),
            Container(
              height: 16,
            ),
          ]),
        );
      case StateRendrerType.content:
        return Container();
    }
  }

  Widget _getColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(text,
          textAlign: TextAlign.center,
          style: getSemiBoldStyle(
            20,
            ColorManager.blackBlue,
            FontsConstants.cairo,
          )),
    );
  }

  Widget _getImage(String image) {
    return Container(
      color: Colors.transparent,
      height: 120,
      width: 120,
      child: Lottie.asset(image),
    );
  }

  Widget _getButton(
    BuildContext context,
    String text,
  ) {
    return SizedBox(
      height: 40,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(
            right: AppSize.queryMargin, left: AppSize.queryMargin),
        child: getCustomButton(
            context,
            text,
            stateRendrerType == StateRendrerType.errorPopUp
                ? () {
                    Navigator.of(context).pop();
                  }
                : () {
                    tryFunction.call();
                  }),
      ),
    );
  }

  Widget _getDialog(List<Widget> children) {
    return Dialog(
      elevation: 2,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
            color: ColorManager.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _getDialogLoading(List<Widget> children) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
