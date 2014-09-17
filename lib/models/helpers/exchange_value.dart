part of transnode;

class ExchangeValue extends RecordModelNested{
  var exchangeRate;
  var factorRate;
  var factor;
  var currentCurrency;
  List exchangeRates;
  List exchangeRatesFactors;
  final ExchangeRateService _exchangeRateService;
  
  ExchangeValue(this._exchangeRateService){
//    this.loadRate();
    currentCurrency = 'USD';
    exchangeRate = 1.11;
    factor = 1.0;
  }
  
  

  loadRateFactors(){
    var request = this._exchangeRateService.index();
    request.then((response){
      exchangeRatesFactors = LoadModel.loadExchangeRates(response.data);
    });
  }
  
  loadRate(){
    var request = this._exchangeRateService.index();
    request.then((response){
      exchangeRates = LoadModel.loadExchangeRates(response.data);
    });
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
