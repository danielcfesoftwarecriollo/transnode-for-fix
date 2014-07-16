part of transnode;

class Shipment extends RecordModel{
  int id;
  int speed_rating;
  int quality_rating;
  int price_rating;
  String file_created;
  String credit_check;

  Shipment() {
    speed_rating = 1;
    quality_rating = 1;
    price_rating = 1;
  }

  Map to_map() {
    return {
      'id' : id,
      'speed_rating'   : speed_rating,
      'quality_rating' : quality_rating,
      'price_rating'   : price_rating
    };
  }

}
