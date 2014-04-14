part of transnode;

@NgController(selector: '[messages-controller]', publishAs: 'messages')
class MessagesController {
  MessagesService _message_service;

  MessagesController(this._message_service);

  bool get hasMessage => _message_service.hasMessage;
  List<String> get messages => _message_service.messages;
}
