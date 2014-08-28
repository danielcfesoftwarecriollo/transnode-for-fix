part of transnode;

class RevenueCost extends RecordModelNested{

  String account_code;
  String amount;
  String currency;
  double amount_ca;
//  Carrier vendor;
  String vendor;
  String description;
  String e_or_p;
  Customer billTo;
  String invoice;
  String status;
  String created_at;
  String updated_at;
  
  RevenueCost(){
    account_code = "5555";
    amount = "5.000";
    currency = "US";
    amount_ca = 5000.0;
    vendor = 'Carrier';
    description = "description";
    e_or_p = 'N/A';
    Customer billTo = new Customer();
    invoice = "5555";
    status = "Applied";
    created_at = "20-08-2014" ;
    updated_at = "27-08-2014" ;
  }

  Map to_map() {
    return {
      'id' : id,
      'account_code' : account_code,
      'amount' : amount,
      'currency' : currency,
      'amount_ca' : amount_ca,
      'vendor' : vendor,
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
