part of transnode;
class ContactValidator extends Validator {
  Contact _contact;

  ContactValidator(this._contact) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_contact.name, 'name');
    format_email(_contact.email, 'email',required:true);
    format_phone(_contact.phone, 'phone');
    return this.valid();
  }
}
