part of transnode;

class Mail extends RecordModelNested{
  String to;
  String subject;
  String body;
  String attachment;
  String full_name;
  
  Mail(){
    // this._validator = new MailValidator(this);
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
  }

  to_map(){
    return {
      'to' : to,
      'body' : body,
      'subject' : subject,
      'attachment' : attachment,
      'full_name' : full_name
    };
  }
  
}
