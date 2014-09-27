import 'package:polymer/polymer.dart';
//import '../../showcase/item.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'package:transnode/data/car.dart' as data;

@CustomTag('search-customer')
class DatatableSearchCustomer extends PolymerElement {
  
  @observable List<data.Car> cars = toObservable(data.cars);
  
  DatatableSearchCustomer.created() : super.created();
  
  void onColumnSorted(CustomEvent event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('Sorted column:', detail);
  }

  void onColumnFiltered(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Column filtered!');
  }
  
}