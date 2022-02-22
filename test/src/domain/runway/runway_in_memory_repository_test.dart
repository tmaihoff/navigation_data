import 'package:aviation_entities/runway.dart';
import 'package:aviation_units/aviation_units.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_data/src/infrastructure/in_memory_repository/runway_in_memory_repository.dart';

void main() {
  final RunwayInMemoryRepository repo = RunwayInMemoryRepository(mockedAll);
  group('runway in memory repository:', () {
    test('find all', () async {
      expect(repo.findAllSets(), mockedAll);
    });
    test('find all sets', () async {
      expect(
          repo.findAll(),
          mockedAll
              .map((e) => [e.direction1, e.direction2])
              .expand((e) => e)
              .toList());
    });

    test('find all by icao code', () async {
      expect(
        repo.findAllByIcaoCode('eddf'),
        [mockedAll[0].direction1, mockedAll[0].direction2],
      );
      expect(
        repo.findAllByIcaoCode('EDDF'),
        [mockedAll[0].direction1, mockedAll[0].direction2],
      );
      expect(repo.findAllByIcaoCode('notfound'), []);
      expect(repo.findAllByIcaoCode('EDDW').length, 2);
    });

    test('find all sets by icao code', () async {
      expect(
        repo.findAllSetsByIcaoCode('eddf'),
        [mockedAll[0]],
      );
      expect(
        repo.findAllSetsByIcaoCode('EDDF'),
        [mockedAll[0]],
      );
      expect(repo.findAllSetsByIcaoCode('notfound'), []);
      expect(repo.findAllSetsByIcaoCode('EDDW').length, 1);
    });
  });
}

const List<RunwaySet> mockedAll = [
  RunwaySet(
    airportIcaoCode: 'EDDF',
    direction1: Runway(
      airportIcaoCode: 'EDDF',
      identifier: '25L',
      trueHeading: Heading(deg: 249),
      length: Length(m: 4000),
      width: Length(m: 60),
      surface: 'ASPH',
      lighted: true,
      closed: false,
      start: Threshold(
        latitude: 50.0,
        longitude: 8.0,
        displaced: Length.zero,
        elevation: Length(m: 50),
      ),
      end: Threshold(
        latitude: 50.0,
        longitude: 7.0,
        displaced: Length.zero,
        elevation: Length(m: 49),
      ),
    ),
    direction2: Runway(
      airportIcaoCode: 'EDDF',
      identifier: '25L',
      trueHeading: Heading(deg: 249),
      length: Length(m: 4000),
      width: Length(m: 60),
      surface: 'ASPH',
      lighted: true,
      closed: false,
      start: Threshold(
        latitude: 50.0,
        longitude: 8.0,
        displaced: Length.zero,
        elevation: Length(m: 50),
      ),
      end: Threshold(
        latitude: 50.0,
        longitude: 7.0,
        displaced: Length.zero,
        elevation: Length(m: 49),
      ),
    ),
  ),
  RunwaySet(
    airportIcaoCode: 'EDDW',
    direction1: Runway(
      airportIcaoCode: 'EDDW',
      identifier: '27',
      trueHeading: Heading(deg: 274),
      length: Length(m: 4000),
      width: Length(m: 60),
      surface: 'ASPH',
      lighted: true,
      closed: false,
      start: Threshold(
        latitude: 54.0,
        longitude: 8.0,
        displaced: Length.zero,
        elevation: Length(m: 50),
      ),
      end: Threshold(
        latitude: 54.0,
        longitude: 7.0,
        displaced: Length.zero,
        elevation: Length(m: 49),
      ),
    ),
    direction2: Runway(
      airportIcaoCode: 'EDDW',
      identifier: '09',
      trueHeading: Heading(deg: 094),
      length: Length(m: 4000),
      width: Length(m: 60),
      surface: 'ASPH',
      lighted: true,
      closed: false,
      start: Threshold(
        latitude: 54.0,
        longitude: 7.0,
        displaced: Length.zero,
        elevation: Length(m: 50),
      ),
      end: Threshold(
        latitude: 54.0,
        longitude: 8.0,
        displaced: Length.zero,
        elevation: Length(m: 49),
      ),
    ),
  ),
];
