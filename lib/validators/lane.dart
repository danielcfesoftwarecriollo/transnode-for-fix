part of transnode;
class LaneValidator extends Validator {
  Lane _lane;

  LaneValidator(this._lane) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_lane.term1, "name");
    required_field(_lane.term2, "code");
    required_string(_lane.serviceNote, "code");
    return this.valid();
  }

}
