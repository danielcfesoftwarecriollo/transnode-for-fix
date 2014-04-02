library transnode.app_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/messages_service.dart';
import 'dart:async';

@NgController(
    selector: '[transnode]',
    publishAs: 'app')
class AppController {
  UserService _user_service;
  MessagesService message;

  AppController(this._user_service,this.message);

  bool get isAuthenticated => _user_service.isAuthenticated;
  String get email => _user_service.email;
  
  bool hasMessage(){
    return message.hasMessage;
  }
  List<String> messages(){
    _clean_messages();
    return message.messages;
  }
  
  void _clean_messages(){
    if(hasMessage()){
      new Future.delayed(const Duration(milliseconds: 3000),(){
        message.clean();
      });
    }    
  }
}

