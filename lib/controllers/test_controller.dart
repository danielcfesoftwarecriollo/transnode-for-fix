part of transnode;

@NgController(selector: '[test-controller]', publishAs: 'testCtrl')
class TestController {
  ApiService _api;
  MessagesService _messagesService;
  String serverResponse;
  Integer messageCount;

  TestController(this._api, this._messagesService) {
    messageCount = 0;
  }

  void authorizedAction() {
    _api.request('get', '/').then((HttpResponse response) {
        _messagesService.add('success', 'Well done!');
    });
  }

  void unauthorizedAction() {
    serverResponse = '';
    _api.request('get', '/test/not_authorized').then((HttpResponse response) {
      serverResponse = 'you should not see this message, because you are not authorized';
    });
  }

  void addMessage() {
    _messagesService.add('info', 'message_' + (messageCount++).toString());
  }
}
