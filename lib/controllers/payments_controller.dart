part of transnode;

@Controller(selector: '[payment-controller]', publishAs: 'ctrl')
class PaymentController {
  RouteProvider _routeProvider;
  Router _router;
  final PaymentService _paymentService;
  final UsersService _usersService;
  final CustomerService _customerService;
  final InvoiceService _invoiceService;
  MessagesService _messageServices;
  @NgTwoWay("payment")
  Payment payment;
  List<Payment> payments;
  Location billTo;
  
  var asyncSelected;
  bool loadingBillTo;
  


  PaymentController(this._invoiceService, this._messageServices,this._customerService,this._paymentService, this._routeProvider, this._router,this._usersService) {
    this.payment = new Payment();
    this.billTo = new Location();
    
//    var payment_id = _routeProvider.parameters['paymentId'];
//    _paymentService.get(payment_id).then((_){ 
//      this.payment = _; 
    
    if(_isAddCashPath()){
      
    }

  }
  
  onSelectBillTo(String billToId){
    var response = _customerService.getLocation(billToId.toString());
    response.then((l){
      this.payment.billTo = l;
      loadInvoicesNotPaid();
    });
  }
  
  loadInvoicesNotPaid(){
    var response = _invoiceService.getInvoicesNotPaidByBillTo(this.payment.billTo.id.toString());
    response.then((invoiceList){
      this.payment.paymentInvoices = loadPaymentInvoices(invoiceList);
    });
  }
  
  loadPaymentInvoices(Map mapList){
    List aux = [];
    mapList['customer_invoices'].forEach((p){
      PaymentInvoice pI = new PaymentInvoice();
      pI.invoice = LoadModel.loadInvoice(p);
      pI.balanceAfter = pI.invoice.balance;
      aux.add(pI);
    });
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
  
  void save(){
    if (this.payment.is_valid()) {
      var response = this._paymentService.save(this.payment);
      response.then((HttpResponse response) {
        print(response);
        if (response == null) return false;
       _router.go('payments', {});
      });
    }
  }
  
  
  bool _isAddCashPath() => _routeProvider.routeName == 'add_cash';

}
