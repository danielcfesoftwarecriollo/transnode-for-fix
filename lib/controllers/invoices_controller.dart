part of transnode;

@Controller(selector: '[invoice-controller]', publishAs: 'ctrl')
class InvoiceController {
  @NgTwoWay("invoice")
  Invoice invoice;
  @NgTwoWay("invoices")
  List<Invoice> invoices;
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  final CustomerService _customerService;
  final InvoiceService _invoiceService;
  Shipment shipment;
  int step;
  
  
  var asyncSelected;
  bool loadingBillTos;
  
  InvoiceController(this._invoiceService, this._customerService, this._shipmentService, this._routeProvider, this._router) {
    this.step = 1;
    if (_isPreviewPath()){
      var shipment_id = _routeProvider.parameters['shipmentId'];
      _loadShipment(shipment_id);
    } else if(_isConsolidatedPatch()){
      loadingBillTos= false;
      var bill_to_id = _routeProvider.parameters['billToId'];
      _loadInvoice(bill_to_id);
    }
    
  }
  
  onSelectBillTo(var billToId){
    _loadInvoice(billToId);
  }
  
  loadBillToCustomer(String val){
      if(val.isNotEmpty){
        var response = _customerService.getLocationByNameAndRole('bill_to',val.toString());
        return response.then((r) =>r);
      }else{
        return [];
      }
    }
  
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
      this.invoice.currency = this.invoice.billTo.currency;
    }
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
      Invoice i = LoadModel.loadInvoice(response.data);
      this.invoice = i;
      this.invoice.selectedItemsLoaded();
    }
  }

  _loadShipment(String shipment_id){
    _shipmentService.get(shipment_id).then((_){
      this.shipment = _;
    });
  }
  
  _loadInvoice(String bill_to_id){
    _invoiceService.getInvoice(bill_to_id).then((_){
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
  bool _isPreviewPath() => _routeProvider.routeName == 'invoice_preview';
  bool _isConsolidatedPatch() => _routeProvider.routeName == 'invoice_consolidated';
}
