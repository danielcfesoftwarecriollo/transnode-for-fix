part of transnode;

class ExchangeValue extends RecordModelNested{
  var exchangeRate;
  var factorRate;
  var factor;
  String fromCurrency;
  String toCurrency;
  Map exchangeRates;
  List<ExchangeRateFactor> exchangeRatesFactors;
  final ExchangeRateFactorService _exchangeRateFactorService ;
  var currenteFactor;
  
  ExchangeValue( this._exchangeRateFactorService){
    fromCurrency ='USD';
    toCurrency = 'CAD';
    currenteFactor = null;
    exchangeRate = 1;
    factor = 1.0;
    exchangeRates = {};
    loadRateFactors();
  }
  
  getExchangeRate(factorName){
    var factor = exchangeRatesFactors.firstWhere((er) => er.name == factorName, orElse: () => null);
    return factor;
  }

  loadRateFactors(){
    var request = this._exchangeRateFactorService.index();
    request.then((response){
      exchangeRatesFactors = LoadModel.loadExchangeRateFactors(response.data);
    });
  }
  
  _hasRateExchage(){
    return (exchangeRates.containsKey(fromCurrency) && exchangeRates[fromCurrency].containsKey(toCurrency));
  }
  _getCurrentRateExchage(){
    return exchangeRates[fromCurrency][toCurrency];
  }
  
//  setCurrency(toCurrency, fromCurrency, currenteFactor){
//    this.currenteFactor = currenteFactor;
//    this.toCurrency = toCurrency;
//    this.fromCurrency = fromCurrency;
//  }
  
  Future loadRateExchange(from){
    var completer = new Completer();
    if(_hasRateExchage()){
      exchangeRate = _getCurrentRateExchage();
      completer.complete( exchangeRate );
    }else{
      var request = this._exchangeRateFactorService.getFactorExchange(from,toCurrency);
      request.then((response){
        exchangeRate = response['exchange_rate'];
        addValueExchange(exchangeRate);
        completer.complete( exchangeRate );
      });
    }   
    return completer.future;
  }

  addValueExchange(valueExchange){
    return exchangeRates.addAll({fromCurrency:{toCurrency : valueExchange}});
  }

  double getFactor(factor){
    var factorModel = double.parse(getExchangeRate(factor).value);
    return factorModel * exchangeRate;
  }

  Future<String> calculateCosts(amount,fromCurrency,factorName){    
     var completer = new Completer();
      loadRateExchange(fromCurrency).then((exchangeRate){
         double aux = ParserNumber.toDouble(amount.toString()) * ( exchangeRate - getFactor(factorName) );
         completer.complete( aux.toStringAsFixed(2) );
       });     
     return completer.future;
  }

  Future<String> calculateRevenue(amount,fromCurrency,factorName){    
     var completer = new Completer();
      loadRateExchange(fromCurrency).then((exchangeRate){
        double aux = ParserNumber.toDouble(amount.toString()) * ( exchangeRate + getFactor(factorName) );
         completer.complete( aux.toStringAsFixed(2) );
       });     
     return completer.future;
  }  
}
