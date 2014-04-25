part of transnode;
class RecordModelNested extends RecordModel {

  int _destroy;
  void delete() {
    _destroy = 1;
  }

  bool pending_to_delete() => _destroy == 1;
}