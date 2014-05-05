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
    format_email(_contact.email, 'email2');
    format_phone(_contact.phone, 'phone');
    format_phone(_contact.phone2, 'phone2');
    format_phone(_contact.mobile, 'mobile');
    return this.valid();
  }
}
