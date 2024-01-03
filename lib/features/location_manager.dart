import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';

import '../core/failure.dart';
import '../core/logger.dart';

class LocationManager {
  late final Location _location = Location();
  LocationData? _locationData;

  LocationManager();

  Future<Either<Failure, LocationData?>> fetchLocationData() async {
    final permissionData = await _checkLocationPermissions();
    if (permissionData.isLeft()) {
      return left(permissionData.getLeft()!);
    }
    _locationData ??= await _location.getLocation();

    logger.i(
      'the location data is fetched :'
      ' \nLatitude : ${_locationData!.latitude}'
      '\nLongitude : ${_locationData!.longitude}',
    );
    return right(_locationData);
  }

  Future<Either<Failure, Unit>> _checkLocationPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.deniedForever) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        return left(const Failure(
            'You have to enable location permission to access your current location'));
      } else if (permissionGranted == PermissionStatus.deniedForever) {
        return left(const Failure(
            'You have to enable location permission to access your current location'));
      }
    }

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (serviceEnabled) {
        return right(unit);
      } else {
        return left(
            const Failure('You have to enable location service to access your current location'));
      }
    }

    return right(unit);
  }

  LocationData? get locationData => _locationData;
}
