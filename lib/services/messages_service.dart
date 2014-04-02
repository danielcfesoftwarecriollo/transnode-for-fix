library transnode.messages_service;

import 'package:angular/angular.dart';

@NgInjectableService()
class MessagesService {
  List<String> _messages;

  MessagesService() {
    _messages = new List<String>();
  }

  List<String> get messages   => _messages;
  bool         get hasMessage => _messages.isNotEmpty;

  void clean(){
    _messages.clear();
  }
  
  void add(String message) {
    _messages.add(message);
  }
}
