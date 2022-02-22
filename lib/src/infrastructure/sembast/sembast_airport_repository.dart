import 'package:aviation_entities/airport.dart';
import 'package:aviation_units/aviation_units.dart';
import 'package:navigation_data/src/domain/airport/airport_repository.dart';
import 'package:navigation_data/src/infrastructure/sembast/sembast_database.dart';
import 'package:sembast/sembast.dart';

class SembastAirportRepository extends AirportRepository {
  final DatabaseClient db;

  SembastAirportRepository(this.db);

  final store = SembastDatabase.airportStore;

  @override
  Future<List<Airport>> findAll() async {
    final List<Record> records = await store.stream(db).toList();
    return records.map((record) => Airport.fromJson(record.value)).toList();
  }

  @override
  Future<List<Airport>> findAllByIataCodeLike(String like) async {
    final finder = _finderByFieldLike(Airport.$iataCode, like);
    return _findAirports(finder, db, store);
  }

  @override
  Future<List<Airport>> findAllByIataCodeStartsWith(String startsWith) async {
    final finder = _finderByFieldStartsWith(Airport.$iataCode, startsWith);
    return _findAirports(finder, db, store);
  }

  @override
  Future<List<Airport>> findAllByIcaoCodeLike(String like) async {
    final finder = _finderByFieldLike(Airport.$icaoCode, like);
    return _findAirports(finder, db, store);
  }

  @override
  Future<List<Airport>> findAllByIcaoCodeStartsWith(String startsWith) async {
    final finder = _finderByFieldStartsWith(Airport.$icaoCode, startsWith); //
    return _findAirports(finder, db, store);
  }

  @override
  Future<List<Airport>> findAllByNameLike(String like) async {
    final finder = _finderByFieldLike(Airport.$name, like);
    return _findAirports(finder, db, store);
  }

  @override
  Future<List<Airport>> findAllByNameStartsWith(String startsWith) async {
    final finder = _finderByFieldStartsWith(Airport.$name, startsWith);
    final airports = await _findAirports(finder, db, store);
    return airports;
  }

  @override
  Future<Airport?> findByIataCode(String iataCode) async {
    final finder = _finderByField(Airport.$iataCode, iataCode);
    return _findAirport(finder, db, store);
  }

  @override
  Future<Airport?> findByIcaoCode(String icaoCode) async {
    final finder = _finderByField(Airport.$icaoCode, icaoCode);
    return _findAirport(finder, db, store);
  }

  @override
  List<Airport> findAllByLocation(
      {required double lat, required double lon, required Length offset}) {
    // TODO: implement findAllByLocation
    throw UnimplementedError();
  }

  @override
  List<Airport> findAllByLatLonRect({
    required double north,
    required double east,
    required double south,
    required double west,
    double buffer = 0,
  }) {
    // TODO: implement findAllByLatLonRect
    throw UnimplementedError();
  }
}

Finder _finderByField(String field, String search) {
  return Finder(
    filter: Filter.matchesRegExp(
      field,
      RegExp('^${search.trim()}\$', caseSensitive: false),
    ),
  );
}

Finder _finderByFieldLike(String field, String search) {
  return Finder(
    filter: Filter.matchesRegExp(
      field,
      RegExp(search.trim(), caseSensitive: false),
    ),
  );
}

Finder _finderByFieldStartsWith(String field, String search) {
  return Finder(
    filter: Filter.matchesRegExp(
      field,
      RegExp('^${search.trim()}', caseSensitive: false),
    ),
  );
}

Future<Airport?> _findAirport(
  Finder finder,
  DatabaseClient db,
  Store store,
) async {
  final record = await store.findFirst(db, finder: finder);
  if (record != null) {
    return Airport.fromJson(record.value);
  }
  return null;
}

Future<List<Airport>> _findAirports(
  Finder finder,
  DatabaseClient db,
  Store store,
) async {
  final records = await store.find(db, finder: finder);
  return records
      .whereType<Record>()
      .map((record) => Airport.fromJson(record.value))
      .toList();
}

typedef Record = RecordSnapshot<String, Map<String, Object?>>;
typedef Query = RecordRef<String, Map<String, Object?>>;
typedef Store = StoreRef<String, Map<String, Object?>>;
