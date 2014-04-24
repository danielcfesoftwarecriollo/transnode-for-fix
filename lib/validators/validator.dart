part of transnode;

class Validator {
  Map<String, List<String>> errors;
  static final String email_regex =
      r'^([0-9a-zA-Z]([-.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})$';
  static final String zip_regex = "^\d{4,5}\$";
  static final String phone_regex =
      r'^(\+\d{1,3})[ -](\d{3})[ -]?(\d{3})[ -]?(\d{4})$';

  bool run_validations() {
    return false;
  }

  bool valid() {
    return errors.isEmpty;
  }

  void required_string(String value, String name_field) {
    if (value == null || value == "") {
      _add_error_required(name_field);
    }
  }
  void format_zip(String value, String name_field, {bool required: false}) {
    if (!_valid_format(value, zip_regex, required)) {
      _add_error("format invalid, should be 5 digits", name_field);
    }
  }
  void format_email(String value, String name_field, {bool required: false}) {
    if (!_valid_format(value, email_regex, required)) {
      _add_error("format invalid", name_field);
    }
  }
  void format_phone(String value, String name_field, {bool required: false}) {
    if (!_valid_format(value, phone_regex, required)) {
      _add_error("format should be: +(01) 123-123-1234", name_field);
    }

  }
  
  bool _valid_format(String value, String expresion, bool required) {
    RegExp regex = new RegExp(expresion);
    if (required && (value == null || value == "")) {
      return false;
    }
    return (value == null || !regex.hasMatch(value));
  }
  
  void required_number(int value, String name_field) {
    if (value == 0 || value == null) {
      _add_error_required(name_field);
    }
  }

  void clean_errors() {
    this.errors = {};
  }

  void setup_errors(Map<String, List<String>> errors_map) {
    this.errors = errors_map;
  }

  String errors_by_field(String field) {
    if (has_errors(field)) {
      return errors[field].join(', ');
    } else {
      return null;
    }
  }

  bool has_errors(String field) {
    return errors.containsKey(field);
  }

  void _add_error_required(String name_field) {
    _add_error("it's required", name_field);
  }
  
  void _add_error(String message, String name_field) {
    if (!errors.containsKey(name_field)) {
      errors[name_field] = new List<String>();
    }
    errors[name_field].add(message);
  }
}
