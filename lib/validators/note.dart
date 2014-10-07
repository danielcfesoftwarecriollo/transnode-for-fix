part of transnode;
class NoteValidator extends Validator {
  Note _note;

  NoteValidator(this._note) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_note.description, "description");
    return this.valid();
  }

}
