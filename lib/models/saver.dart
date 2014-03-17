import 'dart:html';
class Saver{
  bool sucessfull = false;  

  bool sucessful(request){
    return request.readyState == HttpRequest.DONE && (request.status == 200 || request.status == 0);
  }
  String map_to_param(Map map){
    Set<String> params = new Set();
    map.forEach((k,v) => v != null ? params.add(k+'='+v): "" );
    return params.join("&");
  }
}