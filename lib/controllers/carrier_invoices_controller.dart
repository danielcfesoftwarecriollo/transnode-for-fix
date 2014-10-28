part of transnode;

@Controller(selector: '[carrier-invoice-controller]', publishAs: 'ctrl')
class CarrierInvoiceController {
  @NgTwoWay("invoice")
  InvoiceAP invoice;
  @NgTwoWay("invoices")
  List<InvoiceAP> invoices;
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  final InvoiceAPService _invoiceService;
  Shipment shipment;
  int step;
  bool loadingvendors;
  
  var asyncSelected;
  
  CarrierInvoiceController(this._invoiceService, this._shipmentService, this._routeProvider, this._router) {
    this.step = 1;
    this.loadingvendors = false;
    if(_isManagerAPInvoicePatch()){
      var invoiceId = _routeProvider.parameters['invoiceId'];
      _loadInvoice(invoiceId).then((i){
        this.invoice.setValidatorReview();
        this.initItemsReview();
      });
    }    
  }
  
  void selectedAmount(InvoiceItemAP invoiceItem){
    invoiceItem.amount = ParserNumber.toDouble(invoiceItem.cost.amount);
    this.aceptedReview(invoiceItem);
  }
  
  void deselectAmount(InvoiceItemAP invoiceItem){
    invoiceItem.amount = null;
    this.rejectedReview(invoiceItem);
  }
  
  void aceptedReview(InvoiceItemAP invoiceItem){
    invoiceItem.acepte();
    this.invoice.changeSelectedItems();
  }

  void rejectedReview(InvoiceItemAP invoiceItem){
    invoiceItem.rejecte();
    this.invoice.changeSelectedItems();
  }
  
  _checkIsNew(){
    if (this.invoice.is_new()){
      this.invoice.dueDate = DateHelper.addDate(30);
      this.invoice.exportDate = DateHelper.currentDate();
      this.invoice.currency = this.invoice.vendor.currency;
    }
    this.invoice.changeSelectedItems();
  }
  
  void viewPDF(){
    if(this.invoice.id != null){
      window.open("${ApiService.api_url}/customer_invoices/download_consolidated/${this.invoice.id}/invoice.pdf", 'Invoice Consolidate');
    }
  }
    
  initItemsReview(){
    this.invoice.items.forEach((i){
      rejectedReview(i);
    });
    this.chekStatusReview();
  }
  
  chekStatusReview(){
   if(this.invoice.status == StatusInvoice.READY_FOR_EXPORT.value) {
    this.invoice.acepte();
   }else if(this.invoice.status == StatusInvoice.ISSUE.value){
    this.invoice.rejecte();  
   }
  }
    
  void saveReview(){
    if(this.invoice.is_valid()){
      this.invoice.checkInvoiceIssue();
      var response = this._invoiceService.saveReview(this.invoice);
      response.then((response) {
        if (response == null) return false;
        this.updateInvoice(response);
      });
    }
  }

  void save() {
    if (this.invoice.is_valid()) {
      var response = this._invoiceService.save(this.invoice);
      response.then((response) {
        if (response == null) return false;
        this.updateInvoice(response);
      });
    }
  }
  
  void updateInvoice( response ){
    if(response.data.length > 0){
      InvoiceAP i = LoadModel.loadInvoiceAP(response.data);
      this.invoice = i;
      this.invoice.selectedItemsLoaded();
    }
  }

  _loadShipment(String shipment_id){
    _shipmentService.get(shipment_id).then((_){
      this.shipment = _;
    });
  }
  
  Future _loadInvoice(String invoice_id){
    var completer = new Completer();
    _invoiceService.get(invoice_id).then((_){
      this.invoice = _;
      _checkIsNew();
      completer.complete( this.invoice );
    });
    return completer.future;
  }
 
  void toStep(int goToStep){
    if(goToStep == 2 && _isValidInvoice()){
      this.step = 2;
    }else{
      this.step = 1;
    }
  }
  
  bool _isValidInvoice() => this.invoice.is_valid();
  
  bool inStep(int step) => step == this.step;
  bool _isManagerAPInvoicePatch() => _routeProvider.routeName == 'manager_view_invoice';
  bool _isAPInvoicePatch() => _routeProvider.routeName == 'ap_invoice';
}
