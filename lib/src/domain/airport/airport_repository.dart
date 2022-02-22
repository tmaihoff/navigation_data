import 'package:aviation_entities/airport.dart';
import 'package:aviation_units/aviation_units.dart';

abstract class AirportRepository {
  List<Airport> findAll();
  Airport? findByIcaoCode(String icaoCode);
  Airport? findByIataCode(String iataCode);
  List<Airport> findAllByIcaoCodeLike(String icaoCodeLike);
  List<Airport> findAllByIataCodeLike(String iataCodeLike);
  List<Airport> findAllByNameLike(String nameLike);
  List<Airport> findAllByIcaoCodeStartsWith(String startsWith);
  List<Airport> findAllByIataCodeStartsWith(String startsWith);
  List<Airport> findAllByNameStartsWith(String startsWith);
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
