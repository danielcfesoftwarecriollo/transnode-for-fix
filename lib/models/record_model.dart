part of transnode;

abstract class RecordModel {
  int id;
  Validator _validator;

  bool is_valid(){
   return _validator.run_validations();
  }
  
  bool is_new() => id == null;
  
  Map errors_map() {
    return _validator.errors;
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
    InstanceMirror instanceMirror = reflect(this);
    map.forEach((k, v) {
      if( !is_nested_model_attribute(k)){ 
        instanceMirror.setField(new Symbol(underscoreToCamelCase(k)), v);        
      }
    });
  }

  String underscoreToCamelCase(String underscored) {
    String camelCased;
    List<String> names = underscored.split("_");
    List<String> names_capitalized = new List<String>();
    if (names.length > 1){
      camelCased = names[0];
      names.remove(names[0]);
      names.forEach((String part){
        names_capitalized.add(capitalize(part));
      });
      camelCased = camelCased + names_capitalized.join('');      
    } else {
      camelCased = underscored;
    }
    return camelCased;
  }

  String capitalize(String part) {
    return part[0].toUpperCase() + part.substring(1);
  }
  
  bool is_nested_model_attribute(String field){
    List<String> names = field.split("_");
    return names.last == "attributes";
  }
}
