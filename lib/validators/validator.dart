part of transnode;
abstract class Validator {
  Map<String, List<String>> errors;


  bool run_validations();

  bool valid() {
    return errors.isEmpty;
  }

  void required_string(String value, String name_field) {
    if (value == "" || value == null) {
      _add_error_required(name_field);
    }
  }
  
  void required_number(int value, String name_field) {
    if (value == 0 || value == null) {
      _add_error_required(name_field);
    }
  }
  
  void _add_error_required(String name_field) {
    _add_error("it's required",name_field);
  }
  void _add_error(String message, String name_field) {
    if (errors.containsKey(name_field)) {
      errors[name_field] = new List<String>();
    }
    errors[name_field].add(message);
  }
}
