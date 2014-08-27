part of transnode;

class Line extends RecordModelNested{
  int id;
  var length;
  var height;
  var weight;
  var width; 
  var numPcs;
  var hazard;
  var consigneeId;
  var createdAt;
  var updatedAt;
   
  Line(){
    this._validator = new LineValidator(this);
  }
  
  Map to_map() {
    print('lines');
    return {
      'id'    : id,
      'length': length,
      'height': height,
      'weight': weight,
      'width' : width, 
      'num_pcs': numPcs,
      'hazard': hazard,
      'consignee_id': consigneeId,
      '_destroy': _destroy
    };
  }

}
