part of transnode;

class HelperList{
  static  to_map(l) {
    List<Map> l_map = [];
    l.forEach((item){
      l_map.add(item.to_map());
    });
    return l_map;
  }

  static loadWithMap(map){
//    InstanceMirror instanceMirror = reflect(this);
//    ClassMirror MyClassMirror = instanceMirror.type;
//    map.forEach((k, v) {
//        var field = MyClassMirror.declarations[ new Symbol("consignees")];
//        print(field.runtimeType);
//        print(field);
//      instanceMirror.getField(new Symbol(underscoreToCamelCase(k)));
//      if( !is_nested_model_attribute(k)){ 
//        instanceMirror.setField(new Symbol(underscoreToCamelCase(k)), v);        
//      }
//    });
    
    
    print(getInstanceToString('Carrier'));
  }
  
  static getInstanceToString(classString){
    var symbol = new Symbol(classString.toString());
    var myClasses = currentMirrorSystem().findLibrary(#transnode).declarations.values.where((dm) => dm is ClassMirror);
    var cm = myClasses.firstWhere((cm) => cm.simpleName == symbol);
    var instance = cm.newInstance(const Symbol(''), []).reflectee;
    return instance;
  }

  
}