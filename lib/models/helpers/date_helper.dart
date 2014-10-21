part of transnode;

class DateHelper {  
  static DateTime currentDate(){
    return new DateTime.now();
  } 
  
  static DateTime addDate(daysMore){
    var today = new DateTime.now();
    return today.add(new Duration(days: daysMore));
  }
  
  static String formated(date){
    var formatter = new DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }  
}