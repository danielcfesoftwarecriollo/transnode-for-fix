part of transnodeTest;

testCustomer(){
  group('Customer', () {
    test('empty customer no valid', (){
      Customer customer = new Customer();
      CustomerValidator customerValidator = new CustomerValidator(customer);
      customerValidator.run_validations();
      expect(customerValidator.valid(), isFalse);
    });
    group('#rating',(){
      [1,2,3,4,5].forEach((rating){
        test('allow '+rating.toString(),(){
          Customer customer = new Customer();
          customer.loadWithJson(FactoryJson.customer());
          customer.rating = rating;
          CustomerValidator customerValidator = new CustomerValidator(customer);
          customerValidator.run_validations();
          expect(customerValidator.valid(), isTrue);

        });
      });
      [0,6].forEach((rating){
        test('not allow '+rating.toString(),(){
          Customer customer = new Customer();
          customer.loadWithJson(FactoryJson.customer());
          customer.rating = rating;
          CustomerValidator customerValidator = new CustomerValidator(customer);
          customerValidator.run_validations();
          expect(customerValidator.valid(), isFalse);
        });
      });
    });
  });
}
