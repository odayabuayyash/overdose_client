import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/app/shared_preferences.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/resources/image_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../home/view_model/home_viewmodel.dart';

class LocationViewModel extends BaseViewModel
    with LocationInputs, LocationOutputs {
  final StreamController _currentPossitionController =
      BehaviorSubject<GoogleMapInputs>();
  final StreamController _currentPossitionTextController =
      BehaviorSubject<String>();
  TextEditingController textFormController = TextEditingController();
  GoogleMapController? controller;
  final AppPreferences _appPreferences = inectance<AppPreferences>();
  Set<Marker> myMark = Set.from([]);
  late BitmapDescriptor _myIcon;
  double lati = 0; // this is String for latitude
  double langi = 0; // this is String for langitude
  _addIconMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50.0, 70.0)),
            ImageManager.locationIcon)
        .then((val) {
      _myIcon = val;
    });
  }

  @override
  dispose() {
    controller?.dispose();
    _currentPossitionController.close();
    _currentPossitionTextController.close();
  }

  @override
  start() {
    _addIconMarker();
  }

  @override
  Sink get currentLocationTextInput => _currentPossitionTextController.sink;

  @override
  Stream<String> get currentLocationTextOutput =>
      _currentPossitionTextController.stream
          .map((locationText) => locationText);

  @override
  getCurrentLocation() async {
    LatLng? possistion =
        await Geolocator.getCurrentPosition().then((value) async {
      controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 16, target: LatLng(value.latitude, value.longitude))));
      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      langi = value.longitude;
      lati = value.latitude;

      Marker mark = Marker(
          markerId: const MarkerId("user"),
          icon: _myIcon,
          position: LatLng(value.latitude, value.longitude),
          draggable: true,
          onDragEnd: (val) {});
      myMark.add(mark);

      currentLocationTextInput.add(
          "${placemarks.first.locality} , ${placemarks.first.subLocality} , ${placemarks.first.street}");
      currentDataInput.add(GoogleMapInputs(
          LatLng(value.latitude, value.longitude), myMark, _myIcon));
    });
    ;
  }

  Future<Position> getGeoLocationPosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getLocationFromSearch(
        context,
        Location(
            latitude: position.latitude,
            longitude: position.longitude,
            timestamp: position.timestamp ?? DateTime.timestamp()),
        position);

    langi = position.longitude;
    lati = position.latitude;
    Marker mark = Marker(
        markerId: const MarkerId("user"),
        icon: _myIcon,
        position: LatLng(position.latitude, position.longitude),
        draggable: true,
        onDragEnd: (val) {});
    myMark.add(mark);

    currentDataInput.add(GoogleMapInputs(
        LatLng(position.latitude, position.longitude), myMark, _myIcon));

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    currentLocationTextInput.add(
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
    return '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  @override
  getLocationFromSearch(
      BuildContext context, Location locations, Position position) async {
    try {
      String address = await GetAddressFromLatLong(position);
      if (locations != null) {
        if (locations.latitude != null && locations.longitude != null) {
          controller?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 15,
                  target: LatLng(locations.latitude, locations.longitude))));

          Marker mark = Marker(
              markerId: const MarkerId("user"),
              icon: _myIcon,
              position: LatLng(locations.latitude, locations.longitude),
              draggable: true,
              onDragEnd: (val) {});
          myMark.add(mark);
          langi = locations.longitude;
          lati = locations.latitude;

          currentLocationTextInput.add(address);

          currentDataInput.add(GoogleMapInputs(
              LatLng(locations.latitude, locations.longitude),
              myMark,
              _myIcon));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          dismissDirection: DismissDirection.none,
          elevation: 1000,
          backgroundColor: Colors.transparent,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 2 - 50,
              right: 20,
              left: 20),
          content: Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorManager.reed,
                borderRadius: BorderRadius.circular(30)),
            child: const Text(
                textAlign: TextAlign.center,
                "العنوان غير صحيح , يرجى ادخال عنوان موجود"),
          )));
    }
  }

  @override
  saveData(BuildContext context, HomeViewModel homeViewModel, String location,
      double lang, double lat) {
    if (location.isNotEmpty) {
      showToast('تم تحديث العنوان بنجاح',
          context: context,
          fullWidth: true,
          position: StyledToastPosition.top,
          textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
          duration: const Duration(seconds: 4),
          animDuration: const Duration(milliseconds: 200),
          backgroundColor: Colors.green);
      homeViewModel.updateLocation(lat, lang, location);
      Navigator.of(context).pop();
    } else {
      showToast('يجب اختيار العنوان',
          context: context,
          fullWidth: true,
          position: StyledToastPosition.top,
          textStyle: getSemiBoldStyle(14, ColorManager.white, ''),
          duration: const Duration(seconds: 4),
          animDuration: const Duration(milliseconds: 200),
          backgroundColor: Colors.red);
    }
  }

  @override
  updateLocation(LatLng latlng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    langi = latlng.longitude;
    lati = latlng.latitude;

    Marker mark = Marker(
        markerId: const MarkerId("user"),
        icon: _myIcon,
        position: latlng,
        draggable: true,
        onDragEnd: (val) {});
    myMark.add(mark);
    location =
        "${placemarks.first.locality} , ${placemarks.first.subLocality} , ${placemarks.first.street}";
    currentLocationTextInput.add(
        "${placemarks.first.locality} , ${placemarks.first.subLocality} , ${placemarks.first.street}");
    currentDataInput.add(GoogleMapInputs(
        LatLng(latlng.latitude, latlng.longitude), myMark, _myIcon));
  }

  @override
  Sink get currentDataInput => _currentPossitionController.sink;

  @override
  Stream<GoogleMapInputs> get currentDataOutput =>
      _currentPossitionController.stream.map((data) => data);
}

abstract class LocationInputs {
  getLocationFromSearch(
      BuildContext context, Location locations, Position position);
  getCurrentLocation();
  updateLocation(LatLng latlng);
  Sink get currentDataInput;
  Sink get currentLocationTextInput;
  saveData(BuildContext context, HomeViewModel homeViewModel, String location,
      double lang, double lat);
}

abstract class LocationOutputs {
  Stream<GoogleMapInputs> get currentDataOutput;
  Stream<String> get currentLocationTextOutput;
}

class GoogleMapInputs {
  LatLng latlang;
  Set<Marker> marker;
  BitmapDescriptor icon;
  GoogleMapInputs(this.latlang, this.marker, this.icon);
}
