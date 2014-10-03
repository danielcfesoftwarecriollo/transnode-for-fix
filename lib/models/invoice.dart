part of transnode;

class Invoice extends RecordModelNested{

  String status;
  
  Invoice(){
    status = 'New';
//    this._validator = new InvoiceValidator(this);
  }

}
