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
    format_email(_contact.email2, 'email2',required: false);
    format_phone(_contact.phone, 'phone');
    format_phone(_contact.phoneHome, 'phoneHome');
    format_phone(_contact.mobile, 'mobile');

    range_int(_contact.monthBirthday, "monthBirthday",min:1,max:12, required: false);
    range_int(_contact.dayBirthday, "dayBirthday",min:1,max:31, required: false);
    return this.valid();
  }
}
