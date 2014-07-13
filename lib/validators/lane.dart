part of transnode;
class LaneValidator extends Validator {
  Lane _lane;

  LaneValidator(this._lane) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_lane.term1Id, "term1");
    required_field(_lane.term2Id, "term2");
    required_string(_lane.serviceNote, "service-note");
    return this.valid();
  }

}
