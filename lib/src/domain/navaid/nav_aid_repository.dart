import 'package:aviation_entities/nav_aid.dart';
import 'package:aviation_units/aviation_units.dart';

abstract class NavAidRepository {
  List<NavAid> findAll();
  List<NavAid> findAllByLocation({
    required double lat,
    required double lon,
    required Length offset,
  });
  List<NavAid> findAllByLatLonRect({
    required double north,
    required double east,
    required double south,
    required double west,
  });
  List<NavAid> findAllByLatLonAndRadius({
    required double lat,
    required double lon,
    required Length radius,
  });
}
