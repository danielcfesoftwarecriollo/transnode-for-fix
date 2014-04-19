part of transnode;

abstract class RecordModel {
  
  Validator _validator;

  Map<String, List<String>> errors;

  void set_errors(Map<String, List<String>> errors_map) {
    errors_map.forEach((k, v) => errors[underscoreToCamelCase(k)] = v);
  }

  String errors_by_field(String field) {
    if (has_errors(field)) {
      return this.errors[field].join(', ');
    } else {
      return '';
    }

  }
  bool has_errors(String field) {
    return this.errors.containsKey(field);
  }

  void clean_errors() {
    this.errors = {};
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
    camelCased = names[0];
    names.map((String part) => capitalize(part));
    camelCased = camelCased + names.join('');
    return camelCased;
  }

  String capitalize(String part) {
    return part[0].toUpperCase() + part.substring(1);
  }
}
