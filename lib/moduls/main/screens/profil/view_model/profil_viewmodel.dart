import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overdose/app/shared_preferences.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/moduls/main/domain/use_cases/use_caces.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../core/bases/base_viewmodel.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class ProfilViewModel extends BaseViewModel with ProfilInputs, ProfilOutputs {
  RemoteLocalDataSource _dataSource;
  UpdateProfilUseCase _useCase;
  DeleteProfilUseCase _deleteProfilUseCase;
  AppPreferences _preferences;
  ProfilViewModel(this._dataSource, this._useCase, this._deleteProfilUseCase,
      this._preferences);
  final TextEditingController f_nameController = TextEditingController();
  final TextEditingController l_nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final StreamController _enableEditingController = BehaviorSubject<bool>();
  final StreamController _isAcceptedController = BehaviorSubject<bool>();
  final StreamController _firstNameStream = BehaviorSubject<String>();
  final StreamController _stateButtonStream = BehaviorSubject<String?>();
  final StreamController _stateButton2Stream = BehaviorSubject<String?>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isAccepted = false;

  int? id;
  String? firstName = '';

  getUserData() async {
    List<Map>? user = await _dataSource.onReedDbUser();
    f_nameController.text = user?[0]['f_name'].toString() ?? '';
    l_nameController.text = user?[0]['l_name'].toString() ?? '';
    phoneController.text = user?[0]['email'].toString() ?? '';
    emailController.text = user?[0]['phone'].toString() ?? '';
    firstName = user?[0]['f_name'].toString() ?? '';
    id = user?[0]['id'];
    firstNameInput.add(firstName);
    print(user?[0]['token']);
    print(user?[0]['id']);
  }

  changeValue(bool e) {
    isAccepted = e;
    isAceeptedInput.add(e);
  }

  @override
  dispose() {}

  @override
  start() {
    statesButton2Input.add('active');
    getUserData();
    enableEditingInputInput.add(true);
    statesButtonInput.add('active_non');
  }

  @override
  Sink get firstNameInput => _firstNameStream.sink;

  @override
  Stream<String> get firstNameOutputs =>
      _firstNameStream.stream.map((event) => event);

  @override
  Sink get enableEditingInputInput => _enableEditingController.sink;

  @override
  Stream<bool> get enableEditingInputOutputs =>
      _enableEditingController.stream.map((event) => event);

  @override
  enable(bool enable) {
    if (enable == true) {
      enableEditingInputInput.add(false);
      statesButtonInput.add('active');
    } else {
      enableEditingInputInput.add(true);
      statesButtonInput.add('active_non');
    }
  }

  @override
  updateProfil(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (password1Controller.text != '' &&
          password1Controller.text.length > 6 &&
          password2Controller.text != '' &&
          password2Controller.text.length > 6 &&
          f_nameController.text != '' &&
          f_nameController.text.length > 3 &&
          l_nameController.text != "" &&
          l_nameController.text.length > 3) {
        if (password1Controller.text == password2Controller.text) {
          statesButtonInput.add('loading');
          (await _useCase.excute(UpdateProfilInput(
                  id: id!,
                  f_name: f_nameController.text,
                  l_name: l_nameController.text,
                  password: password1Controller.text)))
              .fold(
                  (l) => {
                        showToast('حدث خطا في تحديث البيانات',
                            context: context,
                            position: StyledToastPosition.top,
                            duration: const Duration(seconds: 4),
                            animDuration: const Duration(milliseconds: 200),
                            textStyle:
                                getSemiBoldStyle(14, ColorManager.white, ''),
                            backgroundColor: ColorManager.reed),
                        statesButtonInput.add('active')
                      },
                  (r) => {
                        showToast('تم تحديث البيانات بنجاح',
                            context: context,
                            position: StyledToastPosition.top,
                            duration: const Duration(seconds: 4),
                            animDuration: const Duration(milliseconds: 200),
                            textStyle:
                                getSemiBoldStyle(14, ColorManager.white, ''),
                            backgroundColor: Colors.green),
                        enableEditingInputInput.add(true),
                        statesButtonInput.add('active_non'),
                      });
        } else {
          showToast('كلمة المرور غير متطابقة',
              context: context,
              position: StyledToastPosition.bottom,
              duration: const Duration(seconds: 4),
              animDuration: const Duration(milliseconds: 200),
              textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
              backgroundColor: ColorManager.reed);
        }
      } else {
        showToast('يرجى ملا البيانات بشكل صحيح',
            context: context,
            position: StyledToastPosition.bottom,
            duration: const Duration(seconds: 4),
            animDuration: const Duration(milliseconds: 200),
            textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
            backgroundColor: ColorManager.reed);
      }
    } else {}
  }

  @override
  Sink get statesButtonInput => _stateButtonStream.sink;

  @override
  Stream<String> get statesButtonOutputs =>
      _stateButtonStream.stream.map((event) => event);

  @override
  Sink get isAceeptedInput => _isAcceptedController.sink;

  @override
  Stream<bool> get isAceeptedOutputs =>
      _isAcceptedController.stream.map((event) => event);

  @override
  deleteProdil(BuildContext context) async {
    if (id != null) {
      statesButton2Input.add('loading');
      (await _deleteProfilUseCase.excute(DeleteProdilInput(id!))).fold(
          (l) => {
                showToast('حدث خطا في حذف الحساب',
                    context: context,
                    position: StyledToastPosition.top,
                    duration: const Duration(seconds: 4),
                    animDuration: const Duration(milliseconds: 200),
                    textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
                    backgroundColor: ColorManager.reed),
                statesButton2Input.add('active')
              },
          (r) => {
                statesButton2Input.add('active'),
                _dataSource.onDeleteDbUser(id: id!),
                _preferences.deleteIsLogin(),
                _preferences.deleteLangitude(),
                _preferences.deleteLatitude(),
                _preferences.deleteLocation(),
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.welcomeScreen, (route) => false)
              });
    }
  }

  @override
  Sink get statesButton2Input => _stateButton2Stream.sink;

  @override
  Stream<String> get statesButton2Outputs =>
      _stateButton2Stream.stream.map((event) => event);

  @override
  discounecte(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'تسجيل الخروج ؟',
                    style: getSemiBoldStyle(
                        20, ColorManager.blackBlue, FontsConstants.cairo),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(color: Colors.green, width: 1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                              splashColor:
                                  const Color.fromARGB(255, 43, 78, 45),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'الغاء',
                                style: getSemiBoldStyle(
                                    16, Colors.green, FontsConstants.cairo),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: ColorManager.reed,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                              splashColor:
                                  const Color.fromARGB(255, 184, 124, 15),
                              onPressed: () {
                                _dataSource.onDeleteDbUser(id: id!);
                                _preferences.deleteIsLogin();
                                _preferences.deleteLangitude();
                                _preferences.deleteLatitude();
                                _preferences.deleteLocation();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.welcomeScreen, (route) => false);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.logout_outlined,
                                    color: ColorManager.white,
                                    size: 15,
                                  ),
                                  Text(
                                    'تسجيل الخروج',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ))),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ));
      },
    );
  }
}

abstract class ProfilInputs {
  deleteProdil(BuildContext context);
  Sink get enableEditingInputInput;
  Sink get firstNameInput;
  Sink get statesButtonInput;
  Sink get statesButton2Input;
  discounecte(BuildContext context);
  Sink get isAceeptedInput;
  enable(bool enable);
  updateProfil(BuildContext context);
}

abstract class ProfilOutputs {
  Stream<String> get firstNameOutputs;
  Stream<bool> get enableEditingInputOutputs;
  Stream<bool> get isAceeptedOutputs;
  Stream<String> get statesButtonOutputs;
  Stream<String> get statesButton2Outputs;
}
