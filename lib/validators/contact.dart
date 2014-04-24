part of transnode;
class ContactValidator extends Validator {
  Contact _contact;

  ContactValidator(this._contact) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    format_email(_contact.email, 'email');
    format_phone(_contact.phone, 'phone');
    return this.valid();
  }
}
