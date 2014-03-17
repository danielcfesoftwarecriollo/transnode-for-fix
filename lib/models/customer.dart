library transnode.model.customer;

class Customer{
  String code;
  String name;
  String city;
  String state;
  String zip;
 
  Map to_map(){
    return {
      'code': this.code,
      'name': this.name,
      'city':this.city,
      'state':this.state,
      'zip':this.zip,
     };
   }
}