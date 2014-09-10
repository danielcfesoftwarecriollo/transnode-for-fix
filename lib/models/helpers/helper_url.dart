part of transnode;

class HelperUrl{
  static  parseToUrl(List map) {
    String aux = '';
    map.forEach((v){
      aux += '/' +_stringEmpty(v);
    });
    return aux;
  }
  
  static String _stringEmpty(val){
    if(val == null || val == ''){
      return 'nil';
    }else{
      return val.toString();
    }
  }

}