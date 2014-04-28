part of transnode;

class Validator {
  Map<String, List<String>> errors;
  static final String email_regex =
      r'^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$';
  static final String zip_regex = r"^\d{4,5}$";
  static final String phone_regex =
      r'^(\+\d{1,3})[ -](\d{3})[ -]?(\d{3})[ -]?(\d{4})$';

  bool run_validations() {
    return false;
  }

  bool valid() {
    return errors.isEmpty;
  }

  void clean_errors() {
    this.errors = {};
  }

  void setup_errors(Map<String, List<String>> errors_map) {
    this.errors = errors_map;
  }

  String errors_by_field(String field) {
    if (has_errors(field)) {
      return "${field} ${errors[field].join(', ')}";
    } else {
      return null;
    }
  }

  bool has_errors(String field) {
    return errors.containsKey(field);
  }

  void required_string(String value, String name_field) {
    if (value == null || value == "") {
      _add_error_required(name_field);
    }
  }
  void required_field(value, String name_field) {
    if (!_is_present(value)) {
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
      _add_error("format should be: +01 123 123 1234", name_field);
    }
  }


  void range_int(int value, String name_field, {int min: 1, int max: 5, bool
      required: false}) {
    format_int(value, name_field, required: required);
    if (!has_errors(name_field)) {
      if (value < min || value > max) {
        _add_error("it's out of the range, ${min},${max}", name_field);
      }
    }

  }

  void format_int(int value, String name_field, {bool required: false}) {
    if (!required && !_is_present(value)) {
      return;
    } else if (!_is_present(value) && required) {
      _add_error_required(name_field);
    } else if (value.isNaN || value.toInt() != value) {
      _add_error("Should be a number", name_field);
    }
  }

  void format_double(double value, String name_field, {bool required: false}) {
    if (!required && !_is_present(value)) {
      return;
    } else if (value == null && required) {
      _add_error_required(name_field);
    } else if (value.isNaN) {
      _add_error("Should be a number", name_field);
    }
  }

  bool _is_present(value) => value != null && value.toString() != "";

  bool _valid_format(String value, String expresion, bool required) {
    RegExp regex = new RegExp(expresion);
    if (required && (value == null || value == "")) {
      return false;
    }
    return (value == null || regex.hasMatch(value));
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
