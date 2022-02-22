import 'package:aviation_entities/airport.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_data/navigation_data.dart';
import 'package:navigation_data/src/domain/airport/airport_search_service.dart';
import 'package:navigation_data/src/infrastructure/in_memory_repository/airport_in_memory_repository.dart';

import '../../test_utils.dart';

void main() {
  group('airport search service:', () {
    late Airport lepa;
    late Airport eddw;
    late Airport eddf;
    late Airport icaoA;
    late Airport iataA;
    late Airport nameA;
    late List<Airport> airports;
    late AirportSearchService sut;

    setUp(() async {
      lepa = airport(iataCode: 'pmi', icaoCode: 'lepa', name: 'palma');
      eddw = airport(iataCode: 'bre', icaoCode: 'eddw', name: 'bremen');
      eddf = airport(iataCode: 'fra', icaoCode: 'eddf', name: 'frankfurt');
      icaoA = airport(iataCode: '', icaoCode: 'aaaa', name: '');
      iataA = airport(iataCode: 'aaa', icaoCode: '', name: '');
      nameA = airport(iataCode: '', icaoCode: '', name: 'aaaaaa');
      airports = [lepa, eddw, eddf, icaoA, iataA, nameA];
      sut = AirportSearchService(
        AirportInMemoryRepository(airports),
      );
    });

    test('search by icao code', () async {
      expect((await sut.searchAirports('lepa')).first, lepa);
    });
    test('search by iata code', () async {
      expect((await sut.searchAirports('bre')).first, eddw);
    });
    test('search by name', () async {
      expect((await sut.searchAirports('e')).length, greaterThan(1));
    });
    test('result order for not 3 characters', () async {
      final result = await sut.searchAirports('aa');
      expect(result, [icaoA, iataA, nameA]);
    });
    test('result order for 3 characters', () async {
      final result = await sut.searchAirports('aaa');
      expect(result, [iataA, icaoA, nameA]);
    });
  });
}
