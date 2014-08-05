part of transnode;

@InjectableService()
class MessagesService {
  List<MessageItem> _messages;

  MessagesService() {
    _messages = new List<MessageItem>();
  }

  List<MessageItem> get messages => _messages;
  bool get hasMessage => _messages.isNotEmpty;

  void clean() {
    _messages.clear();
  }

  void add(String type, String content) {
    MessageItem message = new MessageItem(type: type, content: content);
    _messages.add(message);

    new Future.delayed(const Duration(milliseconds: 5000), () {
      _messages.remove(message);
    });
  }

  void delete(MessageItem message) {
    _messages.remove(message);
  }
}

class MessageItem {
  var type;
  var content;

  MessageItem({String this.type:null, String this.content:''});
}
