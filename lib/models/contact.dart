part of transnode;

class Contact {
  String name;
  String phone;
  String email;

  Map to_map() {
    return {
      'name'  : name,
      'phone' : phone,
      'email' : email
    };
  }
}
