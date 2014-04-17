library transnodeTest;

import 'package:unittest/unittest.dart';
import 'package:dartmocks/dartmocks.dart';
import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';

import 'package:transnode/transnode.dart';

part 'services/api_service.dart';
part 'services/location_service.dart';

part 'models/location.dart';

part 'helpers/json.dart';

class TestResponse {
  final data;
  TestResponse(this.data);
  static async(data) => new Future.value(new TestResponse(data));
}

waitForHttp(future, callback) =>
  Timer.run(expectAsync(() {
    inject((MockHttpBackend http) => http.flush());    
    future.then(callback);
  }));

main(){
  setUp(() {
    setUpInjector();
    module((Module m) => m.install(new TransnodeModule()));
   });
   tearDown(tearDownInjector);
  
   testLocation();
}