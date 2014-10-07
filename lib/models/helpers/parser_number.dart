part of transnode;
class ParserNumber{
  static double toDouble(var number) {
    double aux = 0.0;
    if(number != null){
      aux = _doubleHandle(number.toString());
    }
    return aux;
  }
  
  static double _doubleHandle(String number){
    try{
      return double.parse( number);
    }catch(e){
      return 0.0;
    }    
  }
}