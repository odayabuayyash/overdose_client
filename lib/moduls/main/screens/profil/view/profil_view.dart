import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/common/validator/validator_inputs.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/profil/view_model/profil_viewmodel.dart';
import 'package:overdose/moduls/main/screens/profil/widgets/profil_custom_form.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final ProfilViewModel _profilViewModel = inectance<ProfilViewModel>();
  @override
  void initState() {
    _profilViewModel.start();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // centerTitle: true,
          title: Container(
            alignment: Alignment.center,
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
                Text(
                  "حسابي",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
        body: _getContent());
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<bool>(
            stream: _profilViewModel.enableEditingInputOutputs,
            builder: (context, snapshot) => Form(
              key: _profilViewModel.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 96,
                    width: 96,
                    child: Image.asset(ImageManager.perrson),
                  ),
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        _profilViewModel.enable(snapshot.data ?? true);
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Icon(
                            snapshot.data == true ? Icons.edit : Icons.close,
                            color: snapshot.data == true
                                ? ColorManager.primary
                                : ColorManager.reed,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            snapshot.data == true ? 'تعديل الحساب' : 'الغاء',
                            style: getBoldStyle(
                                12,
                                snapshot.data == true
                                    ? ColorManager.primary
                                    : ColorManager.reed,
                                FontsConstants.cairo),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: StreamBuilder<String>(
                      stream: _profilViewModel.firstNameOutputs,
                      builder: (context, snapsh) => Text(
                        'مرحباً ${snapsh.data}',
                        style: getBoldStyle(
                            16, ColorManager.blackBlue, FontsConstants.cairo),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        _profilViewModel.discounecte(context);
                      },
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          const Icon(
                            Icons.logout_outlined,
                            color: ColorManager.grey1,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'تسجيل الخروج',
                            style: getBoldStyle(
                                12, ColorManager.grey1, FontsConstants.cairo),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  // this is just a dialog for delete profil --------------------------------------------
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
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
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: Lottie.asset(
                                            LottieManager.delete,
                                            repeat: false),
                                      ),
                                      Text(
                                        'هل تود حذف الحساب فعلا ؟',
                                        style: getSemiBoldStyle(
                                            20,
                                            ColorManager.blackBlue,
                                            FontsConstants.cairo),
                                      ),
                                      Row(
                                        children: [
                                          StreamBuilder<bool>(
                                              stream: _profilViewModel
                                                  .isAceeptedOutputs,
                                              builder: (context, val) {
                                                return Checkbox(
                                                    value: val.data ?? false,
                                                    activeColor:
                                                        ColorManager.primary,
                                                    onChanged: (e) {
                                                      _profilViewModel
                                                          .changeValue(e!);
                                                    });
                                              }),
                                          Text(
                                            'اوافق على حذف الحساب',
                                            style: getSemiBoldStyle(
                                                14,
                                                ColorManager.blackBlue,
                                                FontsConstants.cairo),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: ColorManager.white,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: MaterialButton(
                                                    splashColor:
                                                        const Color.fromARGB(
                                                            255, 43, 78, 45),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'الغاء',
                                                      style: getSemiBoldStyle(
                                                          16,
                                                          Colors.green,
                                                          FontsConstants.cairo),
                                                    )),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          StreamBuilder<bool>(
                                            stream: _profilViewModel
                                                .isAceeptedOutputs,
                                            builder: (context, isAccepted) =>
                                                Expanded(
                                              child: Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  color: isAccepted.data == true
                                                      ? ColorManager.reed
                                                      : ColorManager.grey1,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: MaterialButton(
                                                      splashColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              184,
                                                              124,
                                                              15),
                                                      onPressed:
                                                          isAccepted.data ==
                                                                  true
                                                              ? () {
                                                                  _profilViewModel
                                                                      .deleteProdil(
                                                                          context);
                                                                }
                                                              : null,
                                                      child: StreamBuilder<
                                                              String>(
                                                          stream: _profilViewModel
                                                              .statesButton2Outputs,
                                                          builder: (context,
                                                                  strng) =>
                                                              strng.data ==
                                                                      'loading'
                                                                  ? const SizedBox(
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                        strokeWidth:
                                                                            2,
                                                                      ))
                                                                  : Text(
                                                                      'حذف',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall,
                                                                    ))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      //  ----------------------------------------------------------------------------------------
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          const Icon(
                            Icons.delete_outlined,
                            color: ColorManager.reed,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'حذف الحساب',
                            style: getBoldStyle(
                                12, ColorManager.reed, FontsConstants.cairo),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm(
                      'اللقب', _profilViewModel.f_nameController, false, (e) {
                    validatorInputs(e, 20, 3, "username");
                  }, TextInputType.text, snapshot.data ?? true),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm(
                      'الاسم', _profilViewModel.l_nameController, false, (e) {
                    validatorInputs(e, 20, 3, "username");
                  }, TextInputType.text, snapshot.data ?? true),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm('البريد الالكتروني',
                      _profilViewModel.emailController, false, (e) {
                    validatorInputs(e, 20, 3, "email");
                  }, TextInputType.emailAddress, true),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm(
                      'رقم الهاتف', _profilViewModel.phoneController, false,
                      (e) {
                    validatorInputs(e, 20, 3, "phone");
                  }, TextInputType.text, true),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm(
                      'كلمة السر', _profilViewModel.password1Controller, true,
                      (e) {
                    validatorInputs(e, 20, 6, "password");
                  }, TextInputType.text, snapshot.data ?? true),
                  const SizedBox(
                    height: 16,
                  ),
                  getProfilCustomForm('تاكيد كلمة السر',
                      _profilViewModel.password2Controller, true, (e) {
                    validatorInputs(e, 20, 6, "password");
                  }, TextInputType.text, snapshot.data ?? true),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<String>(
                      stream: _profilViewModel.statesButtonOutputs,
                      builder: (context, snap) => Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: MaterialButton(
                                  splashColor:
                                      const Color.fromARGB(255, 184, 124, 15),
                                  onPressed: snap.data == "active"
                                      ? () {
                                          _profilViewModel
                                              .updateProfil(context);
                                        }
                                      : null,
                                  child: snap.data == "active" ||
                                          snap.data == 'active_non'
                                      ? Text(
                                          'حفظ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
                                      : const SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                              color: ColorManager.white),
                                        )),
                            ),
                          )),
                  const SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
