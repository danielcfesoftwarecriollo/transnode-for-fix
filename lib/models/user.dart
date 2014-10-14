part of transnode;

class User extends RecordModel {
  int id;
  String email;
  String password;
  String role;
  Contact contact;
  has_role(roleIn) => this.role == roleIn;
  is_admin() => has_role("admin");
  is_csr() => has_role("csr");
  is_csr_admin() => is_admin()||is_csr();
  

  User({this.id, this.email, this.password, this.role});
  
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    _loadContact(map);
    super.loadWithJson(map);
  }

  _loadContact(Map map ){
    if(map['contact'] != null){
      this.contact = LoadModel.loadContact(map['contact']);
    }
    map.remove('contact');
  }
}
