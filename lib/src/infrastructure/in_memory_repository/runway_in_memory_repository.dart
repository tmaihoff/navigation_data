import 'package:aviation_entities/runway.dart';
import 'package:navigation_data/src/domain/runway/runway_repository.dart';

class RunwayInMemoryRepository extends RunwayRepository {
  final List<RunwaySet> _all;

  RunwayInMemoryRepository(this._all);

  @override
  List<Runway> findAll() => _all
      .map((rwySet) => rwySet.getBoth()) //
      .expand((rwy) => rwy) //
      .toList();

  @override
  List<RunwaySet> findAllSets() => _all;

  @override
  List<Runway> findAllByIcaoCode(String icaoCode) {
    return _all
        .where((rwySet) =>
            rwySet.airportIcaoCode.toLowerCase() == icaoCode.toLowerCase())
        .map((rwySet) => rwySet.getBoth())
        .expand((rwy) => rwy)
        .toList();
  }

  @override
  List<RunwaySet> findAllSetsByIcaoCode(String icaoCode) {
    return _all
        .where((rwySet) =>
            rwySet.airportIcaoCode.toLowerCase() == icaoCode.toLowerCase())
        .toList();
  }
}

class RunwaysNotFoundException implements Exception {}
