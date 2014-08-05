part of transnode;

@Controller(selector: '[messages-controller]', publishAs: 'messagesCtrl')
class MessagesController {
  MessagesService _messagesService;

  MessagesController(this._messagesService);

  bool get hasMessage => _messagesService.hasMessage;
  List<MessageItem> get messages => _messagesService.messages;

  void dismiss(MessageItem message) {
    _messagesService.delete(message);
  }

  String cssClassFor(message) {
    return "alert-" + (message.type == null || message.type == '' ? 'warning' : message.type);
  }
}
