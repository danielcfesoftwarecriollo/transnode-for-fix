part of transnode;
 
class StatusInvoice {
  static const NEW_I = const StatusInvoice._('new_i');
  static const ISSUE = const StatusInvoice._('issue');
  static const APPROBED_NEEDED = const StatusInvoice._('approbed_needed');
  static const READY_FOR_EXPORT = const StatusInvoice._('ready_for_export');
  static const EXPORTED = const StatusInvoice._('exported');
  static const CANCELED = const StatusInvoice._('canceled');
  static get values => [NEW_I, ISSUE,APPROBED_NEEDED,READY_FOR_EXPORT,EXPORTED,CANCELED];

  final String value;
  const StatusInvoice._(this.value);
}
