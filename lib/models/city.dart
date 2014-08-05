part of transnode;

class City extends RecordModelNested{
  int id;
  String name;
  String code;
  int stateId;
  bool _expanded;
  Lane(){
    this._validator = new CityValidator(this);
  }
  
  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
  }
  
  Map to_map() {
    return {
      'id' : id,
      'name'  : name,
      'code' : code,
    };
  }
  
  Map to_map_customer(){
    return {
      'id' : id,
      'name'  : name,
      'code' : code,
      '_destroy':_destroy
    };
  }
}
