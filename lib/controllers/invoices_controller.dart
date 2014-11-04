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
  MessagesService _messageServices;
  Map indexFilters;
  Shipment shipment;
  int step;
  bool creditNote;
  Scope scope;
  Modal modal; 
  
  List statusList;
  String statusListSelected;
  
  var asyncSelected;
  bool loadingBillTos;
  String billToSelectedId;
  
  InvoiceController(this.modal,this.scope, this._messageServices,this._invoiceService, this._customerService, this._shipmentService, this._routeProvider, this._router) {
    this.step = 1;
    this.statusList = StatusInvoice.toList();
    loadingBillTos = false;
    this.billToSelectedId = null;
    this.indexFilters = {'status':'all'};
    if (_isPreviewPath()){
      var shipment_id = _routeProvider.parameters['shipmentId'];
      _loadShipment(shipment_id);
    } else if(_isConsolidatedPatch()){
      creditNote = false;
      var bill_to_id = _routeProvider.parameters['billToId'];
      _loadInvoice(bill_to_id);
    }else if(_isCreditNotePatch()){
      creditNote = true;
      var bill_to_id = _routeProvider.parameters['billToId'];
      _loadCreditNote(bill_to_id);
    }else if(_isIndexPath()){
      this.invoices = [];
    }else if(_isViewPath()){
      var invoice_id = _routeProvider.parameters['id'];
      _loadInvoiceById(invoice_id);
    }
  }
  
  _loadInvoiceById(String invoice_id){
    var response =  _invoiceService.get(invoice_id);
    response.then((invoice){
      this.invoice = invoice;
    });
  }
  
  onSelectBillTo(var billToId){
    if(this.creditNote){
      _loadCreditNote(billToId);
    }else{
      _loadInvoice(billToId);
    }
  }
  
  onSelectCustomer(var billToId){
    this.billToSelectedId = billToId;
    searchByBillto(billToId);
  }
  
  searchByBillto(var billToId){
    var response = this._invoiceService.getInvoicesByBillTo(billToId, this.indexFilters);
    response.then((response) {
      if (response == null) return false;
      this.loadInvoices(response);
    });
  }
    
  filterStatusChanged(){
    new Timer(const Duration(milliseconds: 1000), () {
      this.indexFilters['status'] = statusToApi();
      searchByBillto(this.billToSelectedId);
    });
  }

  statusToApi(){
    if(this.statusListSelected == "all"){
      return this.statusListSelected;
    }else{
      return this.statusList.indexOf(this.statusListSelected);
    }
  }
  
  loadInvoices(List map){
    this.invoices = [];
    map.forEach((imap){
      this.invoices.add(LoadModel.loadInvoice(imap));
    });
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
  
  _loadCreditNote(String bill_to_id){
    _invoiceService.getCreditNote(bill_to_id).then((_){
      this.invoice = _;
      _checkIsNew();
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

  void cancelInvoice( Invoice invoice){
    if(window.confirm('you are sure to cancel this invoice?')){
      var response = _invoiceService.cancel(invoice.id.toString());
      response.then((success){
        _messageServices.add("success", "The Invoice has been successfully cancel");
        searchByBillto(this.billToSelectedId);
      });
    }
  }
  
  void reopenInvoice( Invoice invoice){
    if(window.confirm('you are sure to re-open this invoice?')){
      var response = _invoiceService.reOpen(invoice.id.toString());
      response.then((success){
        _messageServices.add("success", "The Invoice has been successfully re-open");
        searchByBillto(this.billToSelectedId);
      });
    }
  }
  
  
  bool _isValidInvoice() => this.invoice.is_valid();
  bool inStep(int step) => step == this.step;
  bool get has_invoices => this.invoices.isNotEmpty;
  
  
  bool _isViewPath() => _routeProvider.routeName == 'invoice_view';
  bool _isIndexPath() => _routeProvider.routeName == 'invoices';
  bool _isPreviewPath() => _routeProvider.routeName == 'invoice_preview';
  bool _isConsolidatedPatch() => _routeProvider.routeName == 'invoice_consolidated';
  bool _isManagerAPInvoicePatch() => _routeProvider.routeName == 'manager_view_invoice';
  bool _isCreditNotePatch() => _routeProvider.routeName == 'credit_note_consolidate';
}
