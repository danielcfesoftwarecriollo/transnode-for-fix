part of transnode;

class Line extends RecordModelNested{
  int id;
  var length;
  var height;
  var weight;
  var width; 
  var num_pcs;
  var hazClass;
  var consigneId;
   
  Line(){
//    this._validator = new LineValidator(this);
  }
  
  Map to_map() {
    return {
      'length': length,
      'height': height,
      'weight': weight,
      'width': width, 
      'num_pcs': num_pcs,
      'hazClass': hazClass,
      'consigneId': consigneId
    };
  }

}
