part of transnode;
class ParserDate{
  static String dateToString(DateTime date) {
    return (date == null)? 'nil':date.toIso8601String();
  }
}