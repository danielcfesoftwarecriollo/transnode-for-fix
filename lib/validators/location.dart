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
      errors['partner_id'] = new List<String>();
      errors['partner_id'].add('is required');
    }
  }
  
  void _check_address() {
    if (_location.address == null || _location.address == '') {
      errors['address'] = new List<String>();
      errors['address'].add('is required');
    }
  }
  
  void _check_state() {
    if (_location.state == null || _location.state == '') {
      errors['state'] = new List<String>();
      errors['state'].add('is required');
    }
  }
  
  void _check_zip() {
    if (_location.zip == null || _location.zip == '') {
      errors['zip'] = new List<String>();
      errors['zip'].add('is required');
    }
  }
  
  void _check_phone() {
    if (_location.phone == null || _location.phone == '') {
      errors['phone'] = new List<String>();
      errors['phone'].add('is required');
    }
  }
  
  void _check_status() {
    if (_location.status == null || _location.status == '') {
      errors['status'] = new List<String>();
      errors['status'].add('is required');
    }
  }

}
