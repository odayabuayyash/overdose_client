import 'package:flutter/material.dart';
import 'package:overdose/app/constants.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer.dart';

abstract class FlowState {
  getMessage();
  getStateRendrerType();
}

class LoadingStatePopUp extends FlowState {
  @override
  getMessage() => Constants.empty;

  @override
  getStateRendrerType() => StateRendrerType.loadinPopUp;
}

class ErrorStatePopUp extends FlowState {
  String message;
  ErrorStatePopUp(this.message);
  @override
  getMessage() => message;

  @override
  getStateRendrerType() => StateRendrerType.errorPopUp;
}

class LoadingStateFullScreen extends FlowState {
  String message;
  LoadingStateFullScreen(this.message);
  @override
  getMessage() => message;

  @override
  getStateRendrerType() => StateRendrerType.loadingFullScreen;
}

class ErrorStateFullScreen extends FlowState {
  String message;
  ErrorStateFullScreen(this.message);
  @override
  getMessage() => message;

  @override
  getStateRendrerType() => StateRendrerType.errorFullScreen;
}

class ContentState extends FlowState {
  @override
  getMessage() => Constants.empty;

  @override
  getStateRendrerType() => StateRendrerType.content;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
      Widget screenWidget, BuildContext context, Function tryFunction) {
    switch (runtimeType) {
      case LoadingStatePopUp:
        dimissDialog(context);
        _showDialog(context, getStateRendrerType(), getMessage(), () {});
        return screenWidget;
      case ErrorStatePopUp:
        dimissDialog(context);

        _showDialog(context, getStateRendrerType(), getMessage(), tryFunction);
        return screenWidget;
      case LoadingStateFullScreen:
        dimissDialog(context);

        return StateRendrer(
          tryFunction: tryFunction,
          stateRendrerType: getStateRendrerType(),
          message: getMessage(),
        );
      case ErrorStateFullScreen:
        dimissDialog(context);

        return StateRendrer(
          tryFunction: tryFunction,
          stateRendrerType: getStateRendrerType(),
          message: getMessage(),
        );
      case ContentState:
        dimissDialog(context);

        return screenWidget;

      default:
        dimissDialog(context);

        return screenWidget;
    }
  }
}

_showDialog(BuildContext context, StateRendrerType stateRendrerType,
    String message, Function tryFunction) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRendrer(
            message: message,
            tryFunction: tryFunction,
            stateRendrerType: stateRendrerType),
      ));
}

isCurrentDialog(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dimissDialog(BuildContext context) {
  if (isCurrentDialog(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}
