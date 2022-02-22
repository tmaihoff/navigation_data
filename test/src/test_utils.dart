import 'package:aviation_entities/airport.dart';
import 'package:aviation_entities/runway.dart';

Airport airport({
  String? icaoCode,
  String? iataCode,
  String? name,
  String? city,
  double? latitude,
  double? longitude,
  double? elevation, // TODO: use Length class?
  String? type,
  List<RunwaySet>? runways,
}) {
  return Airport(
    icaoCode: icaoCode ?? 'ICAO',
    iataCode: iataCode ?? 'ATA',
    name: name ?? 'name',
    city: city ?? 'city',
    latitude: latitude ?? 0,
    longitude: longitude ?? 0,
    elevation: elevation ?? 0,
    type: 'type',
    runways: [],
  );
}
