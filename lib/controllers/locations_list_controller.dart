part of  transnode;


@Controller(selector: '[locations-list-controller]', publishAs: 'ctrl')
class LocationListController{
  List<Location> _locations;
  LocationService _location_service;
  MessagesService _messages_service;
  
  LocationListController(this._location_service,this._messages_service){
    load_locations();
  }
  
  List<Location> get locations => this._locations;
  
  void load_locations(){
    this._locations = [];
    this._location_service.all_index().then((HttpResponse response){
      print(response);
    });
  }
  
}