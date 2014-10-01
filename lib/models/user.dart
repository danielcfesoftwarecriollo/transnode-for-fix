part of transnode;

class User extends RecordModel {
  int id;
  String email;
  String password;
  String role;
  
  is_admin() => role == "admin";
  is_csr() => role == "csr";

  User({this.id, this.email, this.password, this.role});
}
