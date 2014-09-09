part of transnode;

class HelperUrl{
  static  parseToUrl(List map) {
    String aux = '';
    map.forEach((v){
      aux += '/' +_stringEmpty(v);
    });
    return aux;
  }
  
  static String _stringEmpty(String val){
    if(val == null && val.isEmpty){
      return 'nil';
    }else{
      return val;
    }
  }

}