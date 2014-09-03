part of transnode;

class ExchangeValue extends RecordModelNested{
  var exchangeRate;
  var factorRate;
  var factor;
  
  ExchangeValue(){
    exchangeRate = 1.11;
    factor = 1.0;
  }
  double getFactor(){
    return (factor / 100) * exchangeRate;
  }
  
  String calculateCosts(amount){
    double aux = double.parse(amount.toString()) * ( exchangeRate + getFactor() );
     return aux.toStringAsFixed(2);
  }

  String calculateRevenue(amount){
    double aux = double.parse(amount.toString()) * ( exchangeRate - getFactor() );
     return aux.toStringAsFixed(2);
  }
  
}
