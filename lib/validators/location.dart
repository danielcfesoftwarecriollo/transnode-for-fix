part of transnode;
class LocationValidator {
  Location _location;
  Map<String, List<String>> errors;

  LocationValidator(this._location) {
    this.run_validations();
  }

  bool run_validations() {
    errors = new Map<String, List<String>>();    
    _check_partner();
    _check_address();
    _check_state();
    _check_zip();
    _check_phone();
    _check_status();
    return this.valid();
  }
  
  bool valid() {
    return errors.isEmpty;
  }

  void _check_partner() {
    if (_location.partner_id == null || _location.partner_id == 0) {
      errors['partner_id'].add('is required');
    }
  }
  
  void _check_address() {
    if (_location.address.isEmpty) {
      errors['address'].add('is required');
    }
  }
  
  void _check_state() {
    if (_location.state.isEmpty) {
      errors['state'].add('is required');
    }
  }
  
  void _check_zip() {
    if (_location.zip.isEmpty) {
      errors['zip'].add('is required');
    }
  }
  
  void _check_phone() {
    if (_location.phone.isEmpty) {
      errors['phone'].add('is required');
    }
  }
  
  void _check_status() {
    if (_location.status.isEmpty) {
      errors['status'].add('is required');
    }
  }

}
