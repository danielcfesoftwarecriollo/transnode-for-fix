part of transnode;

class Contact extends RecordModelNested{
  String name;
  String phone;
  String email;

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
