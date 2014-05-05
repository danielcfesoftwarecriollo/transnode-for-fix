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
  String birthday;
  String status;
  String typeUser;
  String branchId;
  String locationId;
  String entityType;
  String fax;
  int entityId;

  Contact(){
    this._validator = new ContactValidator(this);
  }

  Map to_map_single(){
    return {
      'name'  : name,
      'phone' : phone,
      'email' : email,
      'title' : title,
      'email_2': email2,
      'phone_home' : phoneHome,
      'mobile': mobile,
      'birthday' : birthday,
      'status' : status,
      'type_user' : typeUser,
      'branch_id': branchId,
      'location_id':locationId
    };
  }
  
  Map to_map() {
    Map single_values = this.to_map_single();
    single_values.addAll({'_destroy':_destroy});
    return single_values;
  }
}
