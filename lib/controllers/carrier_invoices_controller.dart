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
  final CustomerService _customerService;
  final InvoiceAPService _invoiceService;
  Shipment shipment;
  int step; 
  
  var asyncSelected;
  
  CarrierInvoiceController(this._invoiceService, this._customerService, this._shipmentService, this._routeProvider, this._router) {
    this.step = 1;
    if(_isManagerAPInvoicePatch()){
      var invoiceId = _routeProvider.parameters['invoiceId'];
      _loadInvoice(invoiceId);
    }
    
  }

//  loadBillToCustomer(String val){
//      if(val.isNotEmpty){
//        var response = _customerService.getLocationByNameAndRole('bill_to',val.toString());
//        return response.then((r) =>r);
//      }else{
//        return [];
//      }
//    }
  
  void SelectedAmount(InvoiceItem invoiceItem){
    invoiceItem.selected = true;
    invoiceItem.amount = invoiceItem.revenue.amount;
    this.invoice.changeSelectedItems();
  }
  
  void DeselectAmount(InvoiceItem invoiceItem){
      invoiceItem.selected = false;
      invoiceItem.amount = null;
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
  
  _loadInvoice(String invoice_id){
    _invoiceService.get(invoice_id).then((_){
      this.invoice = _;
      _checkIsNew();
    });
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
}
