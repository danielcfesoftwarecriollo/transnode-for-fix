part of transnodeTest;

testLocationService(){
  group('Location-service', () {
      setUp(setUpInjector);
      tearDown(tearDownInjector);

      group("[all]", () {
        setUp(module((Module _) => _
          ..type(MockHttpBackend)
          ..type(ApiService)
          ..type(UserService)
          ..type(MessagesService)
          ..type(LocationService)));
      test('should load all', async(inject((MockHttpBackend http,ApiService api,LocationService locationService) {
       
        http.whenGET("/locations").respond('[{"name":"customer"}]');

        waitForHttp(locationService.all_index(), (locations){
          expect(locations[0].name, equals("Jerry"));
        });
      })));

    });
  });
}
