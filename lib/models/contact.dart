part of transnode;

class Contact extends RecordModelNested{
  String name;
  String phone;
  String email;
  String role;
  String title;
  String email2;
  String phoneHome;
  String mobile;
  String status;
  String typeUser;
  String branchId;
  int _monthBirthday;
  int _dayBirthday;
  String fax;
  int locationId;

  Contact(){
    this._validator = new ContactValidator(this);
  }
  
  int get monthBirthday => _monthBirthday;

  void set monthBirthday(value) {
    if (value == null) {
      _monthBirthday = null;
    } else {
      _monthBirthday = value.toInt();
    }
  }
  
  int get dayBirthday => _dayBirthday;

  void set dayBirthday(value) {
    if (value == null) {
      _dayBirthday = null;
    } else {
      _dayBirthday = value.toInt();
    }
  }
  
  Map to_map() {
    return {
      'name'  : name,
      'phone' : phone,
      'email' : email,
      'title' : title,
      'email_2': email2,
      'phone_home' : phoneHome,
      'mobile': mobile,
      'status' : status,
      'month_birthday' : monthBirthday,
      'day_birthday' : dayBirthday,
      'type_user' : typeUser,
      'branch_id': branchId,
      'location_id': locationId
    };
  }
  
  Map to_map_customer(){
    return {
      'id' : id,
      'name'  : name,
      'phone' : phone,
      'email' : email,
      '_destroy':_destroy
    };
  }
}
