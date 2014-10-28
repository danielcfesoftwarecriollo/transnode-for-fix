part of transnode;
 
class StatusInvoiceItem {
  final String value;
  const StatusInvoiceItem._(this.value);
  toString() => value;
  
  static const NEW_I = const StatusInvoiceItem._('new_i');
  static const ISSUE = const StatusInvoiceItem._('issue');
  static const APPROVED = const StatusInvoiceItem._('approved');
  static const REJECTED = const StatusInvoiceItem._('rejected');
  static const OK = const StatusInvoiceItem._('ok');
  static get values => [NEW_I, ISSUE, APPROVED, REJECTED, OK];
  
}
