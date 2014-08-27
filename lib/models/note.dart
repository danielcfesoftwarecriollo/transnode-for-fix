part of transnode;

class Note extends RecordModelNested{

  String createdAt;
  String updatedAt;
  String description;
  String author;
  
  String user;

  Note(){
    this._validator = new NoteValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
  }
  
  Map to_map() {
    print('lines');
    return {
      'id'    : id,
      'description' : description,
      '_destroy': _destroy
    };
  }
  
}
