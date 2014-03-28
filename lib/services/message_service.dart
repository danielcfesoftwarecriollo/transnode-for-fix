library transnode.message_service;

import 'package:angular/angular.dart';

@NgInjectableService()
class MessageService {
  String _message;
  
  MessageService();
  void set message(String message){
    _message = message;
  }

  String get message => _message;
  
  bool has_message(){
    return message != null;
  }
  void cleanMessage(){
    message = null;
  }
  
  void setError(HttpResponse error){
    this.message = "Error in server, please report it";
  }
  void setConectionRefuse(HttpResponse error){
    this.message = "Turn on Server";
  }
  void setSessionOut(HttpResponse error){
    this.message = "Session is gone, please log again";
  }

  void setForbiddenAccesss(HttpResponse error){
    this.message = "Forbidden Access";
  }
 
}