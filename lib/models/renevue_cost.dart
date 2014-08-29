part of transnode;

class RevenueCost extends RecordModelNested{

  String account_code;
  String amount;
  String currency;
  double amount_ca; //mount with converted if currency is not CAD
  Carrier vendor;
  String description;
  String e_or_p;
  Location billTo;
  String invoice;
// Invoice invoice;
  String status; //change to status int
  
  String created_at;
  String updated_at;
  
  RevenueCost(){
    this._validator = new RevenueCostValidator(this);
  }

  Map to_map() {
    return {
      'id' : id,
      'account_code' : account_code,
      'amount' : amount,
      'currency' : currency,
      'amount_ca' : amount_ca,
      'vendor' : vendor.id,
      'description' : description,
      'e_or_p' : e_or_p,
      'bill_to_id' : billTo.id,
      'invoice' : invoice,
      'status' : status,
      'created_at' : created_at,
      'updated_at' : updated_at
    };
  }

}
