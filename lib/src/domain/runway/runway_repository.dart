import 'package:aviation_entities/runway.dart';

abstract class RunwayRepository {
  List<Runway> findAll();
  List<RunwaySet> findAllSets();
  List<Runway> findAllByIcaoCode(String icaoCode);
  List<RunwaySet> findAllSetsByIcaoCode(String icaoCode);
}
