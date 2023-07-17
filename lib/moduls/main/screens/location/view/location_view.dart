import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/main/screens/home/view_model/home_viewmodel.dart';
import 'package:overdose/moduls/main/screens/location/view_model/location_viewmodel.dart';
import 'package:overdose/moduls/main/screens/location/widgets/custom_form.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key, required this.homeViewModel}) : super(key: key);
  HomeViewModel homeViewModel;
  @override
  State<LocationScreen> createState() => _LocationScreenState(homeViewModel);
}

class _LocationScreenState extends State<LocationScreen> {
  final LocationViewModel _locationViewModel = LocationViewModel();
  HomeViewModel _homeViewModel;
  _LocationScreenState(this._homeViewModel);

  @override
  void initState() {
    _locationViewModel.start();
    _locationViewModel.getGeoLocationPosition(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ColorManager.blackBlue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "تغيير العنوان",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: _getContent(),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
              child: Stack(
            children: [
              StreamBuilder<GoogleMapInputs>(
                stream: _locationViewModel.currentDataOutput,
                builder: (context, snapshot) => GoogleMap(
                    myLocationButtonEnabled: false,
                    onTap: (latlng) async {
                      _locationViewModel.updateLocation(latlng);
                    },
                    onMapCreated: (controller) {
                      _locationViewModel.controller = controller;
                    },
                    zoomControlsEnabled: false,
                    markers: snapshot.data != null
                        ? snapshot.data!.marker.toSet()
                        : <Marker>{},
                    initialCameraPosition: CameraPosition(
                        zoom: 16,
                        target: snapshot.data?.latlang ??
                            const LatLng(35.702977, -0.644322))),
              ),
              Positioned(
                  bottom: 20,
                  right: 20,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: InkWell(
                        onTap: () {
                          _locationViewModel.getCurrentLocation();
                        },
                        child:
                            Image.asset("assets/icons/Current_location.png")),
                  )),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  width: 250,
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("موقعك الحالي",
                          style: getSemiBoldStyle(
                            18,
                            ColorManager.white,
                            FontsConstants.cairo,
                          )),
                      StreamBuilder<String>(
                        stream: _locationViewModel.currentLocationTextOutput,
                        builder: (context, snapshot) => Text(
                          textAlign: TextAlign.center,
                          snapshot.data == null ? "" : "${snapshot.data}",
                          style: getRegularStyle(
                            15,
                            ColorManager.white,
                            FontsConstants.cairo,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
          
          Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 16, bottom: 16),
              child: StreamBuilder<String>(
                stream: _locationViewModel.currentLocationTextOutput,
                builder: (context, snapshot) =>
                    getCustomButton(context, "حفظ", () {
                  _locationViewModel.saveData(
                      context,
                      _homeViewModel,
                      snapshot.data ?? '',
                      _locationViewModel.langi,
                      _locationViewModel.lati);
                }),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _locationViewModel.dispose();
    super.dispose();
  }
}
