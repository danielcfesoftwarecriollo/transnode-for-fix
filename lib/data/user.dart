import 'package:polymer/polymer.dart';

class User extends Object with ChangeNotifier {
  @reflectable @observable String get username => __$username; String __$username; @reflectable set username(String value) { __$username = notifyPropertyChange(#username, __$username, value); }
  @reflectable @observable String get password => __$password; String __$password; @reflectable set password(String value) { __$password = notifyPropertyChange(#password, __$password, value); }
  
  User([username = '', password = '']) : __$username = username, __$password = password;
}