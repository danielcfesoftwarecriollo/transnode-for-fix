part of transnode;
class LineValidator extends Validator {
  Line _line;

  LineValidator(this._line) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    // required_field(_line.term1, "term1");
    // required_field(_line.term2, "term2");
    // required_string(_line.serviceNote, "service-note");
    return this.valid();
  }

}