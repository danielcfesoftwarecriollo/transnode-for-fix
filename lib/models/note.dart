part of transnode;

class Note extends RecordModelNested{

  String createdAt;
  String updatedAt;
  String description;
  
  User user;

  Note(){
    this._validator = new NoteValidator(this);
  }
  
  String get author => (user.contact != null)? user.contact.name : user.email;
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    _loadUser( map );
    super.loadWithJson(map);
  }
  
  _loadUser(Map map ){
    if(map['user'] != null){
      this.user = LoadModel.loadUser(map['user']);
    }
    map.remove('user');
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
