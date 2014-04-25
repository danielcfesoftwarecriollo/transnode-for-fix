part of  transnode;

@NgController(selector: '[location-controller]', publishAs: 'ctrl')
class LocationController{
  Location _location;
  LocationService _location_service;
  MessagesService _messages_service;
  
  LocationController(this._location_service,this._messages_service);
  
  Location get location => this._location;

}
