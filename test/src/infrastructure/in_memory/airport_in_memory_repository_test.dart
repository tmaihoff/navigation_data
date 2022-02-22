import 'package:aviation_entities/airport.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_data/src/infrastructure/in_memory/airport_in_memory_repository.dart';

void main() {
  late AirportInMemoryRepository repo;
  group('airport in memory repository:', () {
    const airports = [
      Airport(
          icaoCode: 'cao1',
          iataCode: 'ta1',
          name: 'name1',
          city: 'city1',
          latitude: 1,
          longitude: 1,
          elevation: 1,
          type: 'medium_airport',
          runways: []),
      Airport(
          icaoCode: 'cao2',
          iataCode: 'ta2',
          name: 'name2',
          city: 'city2',
          latitude: 2,
          longitude: 2,
          elevation: 2,
          type: 'large_airport',
          runways: []),
    ];
    setUp(() async {
      repo = AirportInMemoryRepository(airports);
    });

    test('find all', () async {
      expect(await repo.findAll(), airports);
    });

    test('find by icao code', () async {
      expect(await repo.findByIcaoCode('cao1'), airports[0]);
      expect(await repo.findByIcaoCode('CAO1'), airports[0]);
      expect(await repo.findByIcaoCode('notfound'), null);
    });

    test('find by iata code', () async {
      expect(await repo.findByIataCode('ta2'), airports[1]);
      expect(await repo.findByIataCode('TA2'), airports[1]);
      expect(await repo.findByIataCode('notfound'), null);
    });

    test('find all by iata code like', () async {
      expect(await repo.findAllByIataCodeLike('a2'), [airports[1]]);
      expect(await repo.findAllByIataCodeLike('TA2'), [airports[1]]);
      expect(await repo.findAllByIataCodeLike(''), []);
      expect(await repo.findAllByIataCodeLike('something else'), []);
    });

    test('find all by icao code like', () async {
      expect(await repo.findAllByIcaoCodeLike('ao2'), [airports[1]]);
      expect(await repo.findAllByIcaoCodeLike('O2'), [airports[1]]);
      expect(await repo.findAllByIcaoCodeLike(''), []);
      expect(await repo.findAllByIcaoCodeLike('something else'), []);
    });

    test('find all by name code like', () async {
      expect(await repo.findAllByNameLike('ame2'), [airports[1]]);
      expect(await repo.findAllByNameLike('AME2'), [airports[1]]);
      expect(await repo.findAllByNameLike(''), []);
      expect(await repo.findAllByNameLike('something else'), []);
    });
  });
}
