library transnode.model.customer;
import "package:transnode/models/contact.dart";
class Customer{
  String code;
  String name;
  String city;
  String state;
  String zip;
  List<Contact> contacts;
 
  Customer(){
    this.contacts = [new Contact()];
  }
  
  Contact new_empty_contact(){
    Contact contact = new Contact();
    this.contacts.add(contact);
    return contact;
  }
  bool has_many_contacts(){
    return contacts.length > 1;
  }
  Map to_map(){
    return {
      'code': this.code,
      'name': this.name,
      'city':this.city,
      'state':this.state,
      'zip':this.zip
     };
   }
}