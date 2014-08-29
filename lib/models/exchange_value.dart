part of transnode;

class ExchangeValue extends RecordModelNested{
  var exchangeRate;
  var factorRate;
  var factor;
  
  ExchangeValue(){
    exchangeRate = 1.11;
    factor = 1.0;
  }
  
  double calculateCosts(amount){
    double aux = double.parse(amount.toString()) * ( exchangeRate + factor );
     return aux.truncateToDouble();
  }

  double calculateRevenue(amount){
    double aux = double.parse(amount.toString()) * ( exchangeRate - factor );
     return aux.truncateToDouble();
  }
  
}
