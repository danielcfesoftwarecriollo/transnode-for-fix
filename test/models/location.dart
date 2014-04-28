part of transnodeTest;

testLocation() {
  group('Location', () {
    test('empty no valid', () {
      Location location = new Location();
      LocationValidator locationValidator = new LocationValidator(location);
      locationValidator.run_validations();
      expect(locationValidator.valid(), isFalse);
    });
    test('full is valid', () {
      Location location = new Location();
      location.loadWithJson(FactoryJson.location());
      LocationValidator locationValidator = new LocationValidator(location);
      locationValidator.run_validations();
      expect(locationValidator.valid(), isTrue);
    });

    group('#email', () {
      test("valid test@asd.com", () {
        Location location = new Location();
        location.loadWithJson(FactoryJson.location());
        location.email = "test@asd.com";
        LocationValidator locationValidator = new LocationValidator(location);
        locationValidator.run_validations();
        expect(locationValidator.valid(), isTrue);
      }); 
      test("no valid not_email", () {
        Location location = new Location();
        location.loadWithJson(FactoryJson.location());
        location.email = "not_email";
        LocationValidator locationValidator = new LocationValidator(location);
        locationValidator.run_validations();
        expect(locationValidator.valid(), isFalse);
      });
    });

    group('#zip', () {
      ['12345'].forEach((zip) {
        test("valid ${zip}", () {
          Location location = new Location();
          location.loadWithJson(FactoryJson.location());
          location.zip = zip;
          LocationValidator locationValidator = new LocationValidator(location);
          locationValidator.run_validations();
          expect(locationValidator.valid(), isTrue);
        });
      });
      test('no valid', () {
        ['123456', 'as'].forEach((zip) {
          Location location = new Location();
          location.loadWithJson(FactoryJson.location());
          location.zip = zip;
          LocationValidator locationValidator = new LocationValidator(location);
          locationValidator.run_validations();
          expect(locationValidator.valid(), isFalse);
        });
      });
    });
  });
}
