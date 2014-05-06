part of transnodeTest;

testContact() {
  group('Contact', () {
    test('empty no valid', () {
      Contact contact = new Contact();
      ContactValidator contactValidator = new ContactValidator(contact);
      contactValidator.run_validations();
      expect(contactValidator.valid(), isFalse);
    });
    test('full is valid', () {
      Contact contact = new Contact();
      contact.loadWithJson(FactoryJson.contact());
      ContactValidator contactValidator = new ContactValidator(contact);
      contactValidator.run_validations();
      expect(contactValidator.valid(), isTrue);
    });

    group('#email', () {
      test("valid test@asd.com", () {
        Contact contact = new Contact();
        contact.loadWithJson(FactoryJson.contact());
        contact.email = "test@asd.com";
        ContactValidator contactValidator = new ContactValidator(contact);
        contactValidator.run_validations();
        expect(contactValidator.valid(), isTrue);
      }); 
      group("not valid values",(){
        [null,'not_email'].forEach((value){
          test("no valid ${value}", () {
            Contact contact = new Contact();
            contact.loadWithJson(FactoryJson.contact());
            contact.email = value;
            ContactValidator contactValidator = new ContactValidator(contact);
            contactValidator.run_validations();
            expect(contactValidator.valid(), isFalse);
          });
        });        
      });
    });

  });
}
