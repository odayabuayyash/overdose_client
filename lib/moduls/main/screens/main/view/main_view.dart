import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/card/view/card_view.dart';
import 'package:overdose/moduls/main/screens/home/view/home_view.dart';
import 'package:overdose/moduls/main/screens/location/view/location_view.dart';
import 'package:overdose/moduls/main/screens/main/view_model/main_viewmodel.dart';
import 'package:overdose/moduls/main/screens/more/view/more_view.dart';
import 'package:overdose/moduls/main/screens/more_screens/about/about_view.dart';
import 'package:overdose/moduls/main/screens/more_screens/notifications/view/notifications_view.dart';
import 'package:overdose/moduls/main/screens/order_tracker/view/order_tracker_view.dart';
import 'package:overdose/moduls/main/screens/profil/view/profil_view.dart';
import 'package:stylish_bottom_bar/helpers/bottom_bar.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainViewModel _mainViewModel = MainViewModel();

  @override
  void initState() {
    _mainViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: StreamBuilder<int>(
          stream: _mainViewModel.currentIndexOutput,
          builder: (context, snapshot) => StylishBottomBar(
            items: [
              BottomBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset(IconsManager.more),
                ),
                title: Text(
                  "القائمة",
                  style: getBoldStyle(
                      12,
                      snapshot.data == 0
                          ? ColorManager.primary
                          : ColorManager.greyBlue,
                      FontsConstants.cairo),
                ),
                selectedColor: ColorManager.primary,
                selectedIcon: Image.asset(IconsManager.moreSelected),
              ),
              BottomBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset(IconsManager.user),
                ),
                title: Text(
                  "حسابي",
                  style: getBoldStyle(
                      12,
                      snapshot.data == 1
                          ? ColorManager.primary
                          : ColorManager.greyBlue,
                      FontsConstants.cairo),
                ),
                selectedIcon: Image.asset(IconsManager.userSelected),
              ),
              BottomBarItem(
                icon: SizedBox(),
                title: SizedBox(),
                selectedIcon: SizedBox(),
              ),
              BottomBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset(IconsManager.bag),
                ),
                title: Text(
                  "العروض",
                  style: getBoldStyle(
                      12,
                      snapshot.data == 3
                          ? ColorManager.primary
                          : ColorManager.greyBlue,
                      FontsConstants.cairo),
                ),
                selectedIcon: Image.asset(IconsManager.bagSelected),
              ),
              BottomBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: Image.asset(IconsManager.menu),
                ),
                title: Text(
                  "طلباتي",
                  style: getBoldStyle(
                      12,
                      snapshot.data == 4
                          ? ColorManager.primary
                          : ColorManager.greyBlue,
                      FontsConstants.cairo),
                ),
                selectedColor: ColorManager.primary,
                selectedIcon: Image.asset(IconsManager.menuSelected),
              ),
            ],
            option: AnimatedBarOptions(
                iconSize: 27,
                iconStyle: IconStyle.Default,
                inkColor: ColorManager.primary),
            fabLocation: StylishBarFabLocation.center,
            currentIndex: _mainViewModel.indx,
            hasNotch: true,
            onTap: (index) {
              _mainViewModel.jompToPage(index);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 76,
          width: 76,
          child: StreamBuilder<int>(
            stream: _mainViewModel.currentIndexOutput,
            builder: (context, snapshot) => FloatingActionButton(
              backgroundColor: snapshot.data == 2
                  ? ColorManager.primary
                  : ColorManager.greyBlue,
              onPressed: () {
                _mainViewModel.jompToPage(2);
              },
              child: SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  'assets/images/homecopy.svg',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _getContent(),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: PageView(
        controller: _mainViewModel.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MoreScreen(),
          ProfilScreen(),
          HomeScreen(),
          NotificationsScreen(loc: 0),
          OrderTrackerScreen(loc: 0),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mainViewModel.dispose();
    super.dispose();
  }
}
