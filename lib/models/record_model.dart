part of transnode;

abstract class RecordModel {
  void load_with_json(Map<String, dynamic> map) {
    Mirror instanceMirror = reflect(this);
    map.forEach((k,v){
      instanceMirror.setField(new Symbol(k), v);
    });
  }
}