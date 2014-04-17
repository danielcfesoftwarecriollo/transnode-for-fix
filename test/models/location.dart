part of transnodeTest;

testLocation(){
  group('Location', () {
    test('empty location no valid', (){
          Location location = new Location();
          expect(location.valid, isFalse);
    });
    test('empty location no valid', (){
      Location location = new Location();
      location.load_with_json(FactoryJson.location());
      expect(location.valid, isTrue);
    });        
  });
}
