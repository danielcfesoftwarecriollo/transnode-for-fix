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
  Shipment shipment;
  
  
  var asyncSelected;
  bool loadingBillTos;
  
  InvoiceController(this._customerService, this._shipmentService, this._routeProvider, this._router) {
    
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




  _loadShipment(String shipment_id){
    _shipmentService.get(shipment_id).then((_){
      this.shipment = _;
    });
  }
  
  _loadInvoice(String bill_to_id){
    _customerService.getInvoice(bill_to_id).then((_){
      this.invoice = _;
    });
  }
  
  bool _isPreviewPath() => _routeProvider.routeName == 'invoice_preview';
  bool _isConsolidatedPatch() => _routeProvider.routeName == 'invoice_consolidated';
}
