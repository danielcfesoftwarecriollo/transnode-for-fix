part of transnode;
class ContactValidator extends Validator{
  Contact _contact;

  ContactValidator(this._contact){
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    email_format(_contact.email,'email');
    format_phone(_contact.phone,'phone');
    return this.valid();
  }
}
