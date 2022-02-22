import 'dart:math';

import 'package:aviation_entities/airport.dart';
import 'package:aviation_units/aviation_units.dart';
import 'package:collection/collection.dart';
import 'package:navigation_data/src/domain/airport/airport_repository.dart';

class AirportInMemoryRepository extends AirportRepository {
  final List<Airport> _all;

  AirportInMemoryRepository(this._all);

  @override
  List<Airport> findAll() => _all;

  @override
  Airport? findByIcaoCode(String icaoCode) {
    final searchBy = icaoCode.trim().toLowerCase();
    if (icaoCode.length > 4) return null;

    return _all.firstWhereOrNull(
      (airport) => airport.icaoCode.toLowerCase() == searchBy,
    );
  }

  @override
  Airport? findByIataCode(String iataCode) {
    if (iataCode.length > 3) return null;

    final searchBy = iataCode.trim().toLowerCase();
    return _all.firstWhereOrNull(
        (airport) => airport.iataCode.toLowerCase() == searchBy);
  }

  @override
  List<Airport> findAllByIataCodeLike(String iataCodeLike) {
    final searchBy = iataCodeLike.trim().toLowerCase();

    if (iataCodeLike.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .iataCode //
              .toLowerCase() //
              .contains(searchBy),
        )
        .toList();
  }

  @override
  List<Airport> findAllByIcaoCodeLike(String icaoCodeLike) {
    final searchBy = icaoCodeLike.trim().toLowerCase();

    if (icaoCodeLike.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .icaoCode //
              .toLowerCase() //
              .contains(searchBy),
        )
        .toList();
  }

  @override
  List<Airport> findAllByNameLike(String nameLike) {
    final searchBy = nameLike.trim().toLowerCase();

    if (nameLike.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .name //
              .toLowerCase() //
              .contains(searchBy),
        )
        .toList();
  }

  @override
  List<Airport> findAllByIataCodeStartsWith(String startsWith) {
    final searchBy = startsWith.trim().toLowerCase();

    if (startsWith.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .iataCode //
              .toLowerCase() //
              .startsWith(searchBy),
        )
        .toList();
  }

  @override
  List<Airport> findAllByIcaoCodeStartsWith(String startsWith) {
    final searchBy = startsWith.trim().toLowerCase();

    if (startsWith.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .icaoCode //
              .toLowerCase() //
              .startsWith(searchBy),
        )
        .toList();
  }

  // TODO: test starts with methods
  @override
  List<Airport> findAllByNameStartsWith(String startsWith) {
    final searchBy = startsWith.trim().toLowerCase();

    if (startsWith.isEmpty) return [];

    return _all
        .where(
          (airport) => airport //
              .name //
              .toLowerCase() //
              .startsWith(searchBy),
        )
        .toList();
  }

  @override
  List<Airport> findAllByLocation({
    required double lat,
    required double lon,
    required Length offset,
  }) {
    // TODO: outsource and test this calculation
    final offsetLat = offset.nm / 60;
    final offsetLon = offset.nm / 60 / cos(Angle(deg: lat).rad);

    return _all
        .where(
          (airport) =>
              airport.latitude <= lat + offsetLat &&
              airport.latitude >= lat - offsetLat &&
              airport.longitude <= lon + offsetLon &&
              airport.longitude >= lon - offsetLon,
        )
        .toList();
  }

  @override
  List<Airport> findAllByLatLonRect({
    required double north,
    required double east,
    required double south,
    required double west,
  }) {
    return _all
        .where(
          (airport) =>
              airport.latitude <= north &&
              airport.latitude >= south &&
              airport.longitude <= east &&
              airport.longitude >= west,
        )
        .toList();
  }
}
