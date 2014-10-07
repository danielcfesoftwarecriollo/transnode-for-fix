part of transnode;
class ParserNumber{
  static double toDouble(var number) {
    double aux = 0.0;
    if(number != null){
      aux = _doubleHandle(number);
    }
    return aux;
  }
  
  static double _doubleHandle(var number){
    try{
      return double.parse(number);
    }catch(e){
      return 0.0;
    }    
  }
}