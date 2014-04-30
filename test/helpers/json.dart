part of transnodeTest;

class FactoryJson {
  static Map location() {
    return {
      'partner_id': 1,
      'address_1': "Some direction",
      'country': "US",
      'state': "CA",
      'zip': "1234",
      'city': 'TX',
      'phone': "+01 123 123 1234",
      "email" : "test@email.com",
      'status': "ok"
    };
  }
  static Map contact(){
   return {
     'name': 'name',
     'email': 'email@test.com',
     'phone': '+01 123 123 1234'
   };
  }
  static Map customer() {
    return {
      'name': 'name',
      'state': "CA",
      "rating": 1
    };
  }
  static Map customer_and_location() {
    Map map = FactoryJson.customer();
    map.addAll({
      'location_attributes': FactoryJson.location()
    });
    return map;
  } 
}
