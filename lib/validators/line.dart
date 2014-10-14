part of transnode;
class LineValidator extends Validator {
  Line _line;

  LineValidator(this._line) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_line.length, "length");
     required_field(_line.height, "height");
     required_field(_line.weight, "weight");
     required_field(_line.width, "width");
     required_field(_line.numPcs, "numPcs");
     required_field(_line.hazard, "hazard");
     required_field(_line.consigneeId, "consigneeId");
    return this.valid();    
  }

}
