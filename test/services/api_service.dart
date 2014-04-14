part of transnodeTest;

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

testUsersRepository(){
    // TODO
}
