part of transnode;

class Contact extends RecordModel{
  String name;
  String phone;
  String email;

  Contact(){
    this._validator = new ContactValidator(this);
  }
  Map to_map() {
    return {
      'name'  : name,
      'phone' : phone,
      'email' : email
    };
  }
}
