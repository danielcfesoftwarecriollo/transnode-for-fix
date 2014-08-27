part of transnode;

class HelperList{
  static  to_map(l) {
    List<Map> l_map = [];
    l.forEach((item){
      l_map.add(item.to_map());
    });
    
    return (l_map.isEmpty)? null : l_map;
  }

  static getInstanceToString(classString){
    var symbol = new Symbol(classString.toString());
    var myClasses = currentMirrorSystem().findLibrary(#transnode).declarations.values.where((dm) => dm is ClassMirror);
    var cm = myClasses.firstWhere((cm) => cm.simpleName == symbol);
    var instance = cm.newInstance(const Symbol(''), []).reflectee;
    return instance;
  }

  
}