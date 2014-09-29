part of transnode;

class Rating extends RecordModel{

  int carrierId;
  int typeRating;
  int value;
  String createdAt;
  String updatedAt;
  
  static final int SPEED = 1;
  static final int QUOALITY = 2;
  static final int PRICE = 3;
  
  Rating(this.typeRating){
    value = 5;
  }
  
  set_quality(){
    typeRating = QUOALITY;
  }
  
  set_speed(){
    typeRating = SPEED;    
  }
  
  set_price(){
    typeRating = PRICE;    
  }
  
  Map to_map() {
    var x = null;
    return {
      'id'    : id,
      'carrier_id'  : carrierId,
      'type_rating' : typeRating,
      'value' : value
    };
  }
  
}
