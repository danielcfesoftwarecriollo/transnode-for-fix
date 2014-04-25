part of transnodeTest;

testLocation(){
  group('Location', () {
    test('empty location no valid', (){
          Location location = new Location();
          LocationValidator locationValidator = new LocationValidator(location);
          expect(locationValidator.valid(), isFalse);
    });
    test('empty location no valid', (){
      Location location = new Location();
      location.loadWithJson(FactoryJson.location());
      LocationValidator locationValidator = new LocationValidator(location);
      expect(locationValidator.valid(), isTrue);
    });        
  });
}
