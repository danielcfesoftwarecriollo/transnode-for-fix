part of transnode;

class Contact extends RecordModelNested{
  String name;
  String phone;
  String email;
  String role;
  String title;
  String email2;
  String phone2;
  String mobile;
  String birthday;
  String status;
  String type_contact;
  int branchId;
  int locationId;

  Contact(){
    this._validator = new ContactValidator(this);
  }
    
  Map to_map() {
    return {
      'id' : id,
      'name'  : name,
      'phone' : phone,
      'email' : email,
      '_destroy':_destroy      
    };
  }
}
