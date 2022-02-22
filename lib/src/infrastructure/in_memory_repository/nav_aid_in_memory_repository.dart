import 'dart:math';

import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_units/aviation_units.dart';
import 'package:navigation_data/src/domain/navaid/nav_aid_repository.dart';

class NavAidInMemoryRepository extends NavAidRepository {
  final List<NavAid> _all;

  NavAidInMemoryRepository(this._all);

  @override
  List<NavAid> findAll() => _all;

  @override
  List<NavAid> findAllByLocation({
    required double lat,
    required double lon,
    required Length offset,
  }) {
    // TODO: outsource and test this calculation
    final offsetLat = offset.nm / 60;
    final offsetLon = offset.nm / 60 / cos(Angle(deg: lat).rad);

    return _all
        .where(
          (navaid) =>
              navaid.latitude <= lat + offsetLat &&
              navaid.latitude >= lat - offsetLat &&
              navaid.longitude <= lon + offsetLon &&
              navaid.longitude >= lon - offsetLon,
        )
        .toList();
  }

  @override
  List<NavAid> findAllByLatLonRect({
    required double north,
    required double east,
    required double south,
    required double west,
  }) {
    return _all
        .where(
          (navAid) =>
              navAid.latitude <= north &&
              navAid.latitude >= south &&
              navAid.longitude <= east &&
              navAid.longitude >= west,
        )
        .toList();
  }

  // TODO: test this class
  @override
  List<NavAid> findAllByLatLonAndRadius({
    required double lat,
    required double lon,
    required Length radius,
  }) {
    return _all
        .where(
          (navAid) => navAid.latLng.distanceTo(LatLng(lat, lon)) <= radius,
        )
        .toList();
  }
}
