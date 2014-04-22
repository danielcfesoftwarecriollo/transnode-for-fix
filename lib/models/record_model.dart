part of transnode;

abstract class RecordModel {
  
  Validator _validator;

  bool is_valid(){
   return _validator.run_validations();    
  }
  
  void set_errors(Map<String, List<String>> errors_map) {
    Map<String, List<String>> errors;    
    errors_map.forEach((k, v) => errors[underscoreToCamelCase(k)] = v);
    _validator.setup_errors(errors);
  }

  String errors_by_field(String field) {
    return _validator.errors_by_field(field);
  }
  
  bool has_errors(String field) {
    return _validator.has_errors(field);
  }

  void clean_errors() {
    _validator.clean_errors();
  }

  void loadWithJson(Map<String, dynamic> map) {
    Mirror instanceMirror = reflect(this);
    map.forEach((k, v) {
      instanceMirror.setField(new Symbol(underscoreToCamelCase(k)), v);
    });
  }

  String underscoreToCamelCase(String underscored) {
    String camelCased;
    List<String> names = underscored.split("_");
    if (names.length > 1){
      camelCased = names[0];
      names.map((String part) => capitalize(part));
      camelCased = camelCased + names.join('');      
    } else {
      camelCased = underscored;
    }
    return camelCased;
  }

  String capitalize(String part) {
    return part[0].toUpperCase() + part.substring(1);
  }
}
