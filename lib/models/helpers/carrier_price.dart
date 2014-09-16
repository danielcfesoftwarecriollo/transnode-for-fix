part of transnode;

class CarrierPrice{
  Carrier carrier;
  Lane lane;
  bool selected;
  
  CarrierPrice(carrier, lane, selected){
    this.selected = selected;
    this.carrier = carrier;
    this.lane = lane;
  }
}