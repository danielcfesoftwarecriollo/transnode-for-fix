part of transnode;

@Controller(selector: '[payment-controller]', publishAs: 'ctrl')
class PaymentController {
  RouteProvider _routeProvider;
  Router _router;
  final PaymentService _paymentService;
  final UsersService _usersService;
  final ExchangeRateFactorService _exchangeRateFactorService;
  final CustomerService _customerService;
  final InvoiceService _invoiceService;
  MessagesService _messageServices;
  @NgTwoWay("payment")
  Payment payment;
  Customer customer;
  List<Payment> payments;
  Location billTo;
  ExchangeValue _exchange;
  bool saved;
  
  var asyncSelected;
  bool loadingBillTo;
  Map total;

  PaymentController(this._exchangeRateFactorService,this._invoiceService, this._messageServices,this._customerService,this._paymentService, this._routeProvider, this._router,this._usersService) {
    this._exchange = new ExchangeValue(_exchangeRateFactorService);
    this.payment = new Payment();
    this.billTo = new Location();
    this.saved = false;
    this.total = {'total': 0,'balance': 0,'amount': 0,'localAmount':0,'balanceAfter':0};
    if(_isAddCashPath()){
      
    }

  }
  
  checkTotal(){
    this.total = {'total': 0,'balance': 0,'amount': 0,'localAmount':0 ,'balanceAfter':0};
    this.payment.paymentInvoices.forEach((pI){
      this.total['total'] += ParserNumber.toDouble(pI.invoice.total);
      this.total['balance'] += ParserNumber.toDouble(pI.invoice.balance);
      this.total['amount'] += ParserNumber.toDouble(pI.amount);
      this.total['localAmount'] += ParserNumber.toDouble(pI.localAmount);
      this.total['balanceAfter'] += ParserNumber.toDouble(pI.balanceAfter);
    });
    exchangeLocalAmount();
    checkBalanceOfPay();    
  }
  
  changeCurrency(){
    new Timer(const Duration(milliseconds: 200), () {
      checkAllBalanceAfter();
    });
  }
  
  exchangeLocalAmount(){
    _exchange.calculateExchange(this.payment.currency, "CAD", this.payment.amount).then((localAmount){
      this.payment.localAmount = localAmount;      
    });
  }
  
  checkBalanceOfPay(){
    this.payment.balancePay = ParserNumber.toDouble(this.payment.amount) - this.total['localAmount'];
  }
  
  checkBalanceAfter(PaymentInvoice paymentInvoice){
    paymentInvoice.checkBalanceAfter();
    _exchange.calculateExchange(paymentInvoice.invoice.currency, this.payment.currency, paymentInvoice.amount).then((localAmount){
      paymentInvoice.localAmount = localAmount;
      checkTotal();
    });    
  }
  
  checkAllBalanceAfter(){
    this.payment.paymentInvoices.forEach((pI){
      this.checkBalanceAfter(pI);
    });
  }
  
  onSelectBillTo(String billToId){
    var response = _customerService.getLocation(billToId.toString());
    response.then((l){
      this.payment.billTo = l;
      LoadCustomer(l.customerId.toString());
      loadInvoicesNotPaid();
    });
  }
  
  loadInvoicesNotPaid(){
    var response = _invoiceService.getInvoicesNotPaidByBillTo(this.payment.billTo.id.toString());
    response.then((invoiceList){
      this.payment.paymentInvoices = loadPaymentInvoices(invoiceList);
      checkTotal();
    });
  }
  
  loadPaymentInvoices(Map mapList){
    List<PaymentInvoice> aux = [];
    mapList['customer_invoices'].forEach((p){
      PaymentInvoice pI = new PaymentInvoice();
      pI.invoice = LoadModel.loadInvoice(p);
      pI.balanceAfter = ParserNumber.toDouble(pI.invoice.balance);
      aux.add(pI);
    });
    if(aux.isNotEmpty){
      this.payment.currency = aux.first.invoice.currency;
    }
    return aux;
  }
  
  loadBillToCustomer(String billToName){
    if(billToName.isNotEmpty){
      var response = _customerService.getLocationByNameAndRole('bill_to',billToName.toString());
      return response.then((r) =>r);
    }else{
      return [];
    }
  }
  
  LoadCustomer(billToId){
    var response = _customerService.get(billToId);
    response.then((c){
      this.customer = c;
    });
  }
  
  void save(){
    if (this.payment.full_validator()) {
      if(window.confirm('you are sure to save this Paiment?')){
        var response = this._paymentService.save(this.payment);
        response.then((HttpResponse response) {
          print(response);
          if (response == null) return false;
          _messageServices.add("success", "The Payment has been successfully save");
          this.saved = true;
          new Timer(const Duration(milliseconds: 2000), () {
            window.location.reload();
          });
         
        });
      }
    }
  }
  
  
  bool _isAddCashPath() => _routeProvider.routeName == 'add_cash';

}
