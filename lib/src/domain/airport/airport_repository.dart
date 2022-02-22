import 'package:aviation_entities/airport.dart';
import 'package:aviation_units/aviation_units.dart';

abstract class AirportRepository {
  Future<List<Airport>> findAll();
  Future<Airport?> findByIcaoCode(String icaoCode);
  Future<Airport?> findByIataCode(String iataCode);
  Future<List<Airport>> findAllByIcaoCodeLike(String icaoCodeLike);
  Future<List<Airport>> findAllByIataCodeLike(String iataCodeLike);
  Future<List<Airport>> findAllByNameLike(String nameLike);
  Future<List<Airport>> findAllByIcaoCodeStartsWith(String startsWith);
  Future<List<Airport>> findAllByIataCodeStartsWith(String startsWith);
  Future<List<Airport>> findAllByNameStartsWith(String startsWith);
  List<Airport> findAllByLocation({
    required double lat,
    required double lon,
    required Length offset,
  });

  List<Airport> findAllByLatLonRect({
    required double north,
    required double east,
    required double south,
    required double west,
  });
}
