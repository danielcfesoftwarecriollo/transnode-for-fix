part of transnode;

@InjectableService()
class UsersService {
  ApiService _api;

  UsersService(this._api);

  Future<List<User>> all() =>
    _api.request("get", "/users")
    .then((_) => _.data['users'].map(_deserialize).toList());

  Future<User> save(User newUser) {
    return _api.request("post", "/users", data: _serialize(newUser))
           .then((_) => _deserialize(_.data['user']));
  }

  Future delete(User existentUser) {
    return _api.request("delete", "/users/" + existentUser.id.toString());
  }

  Future<User> get(String userId) {
    return _api.request("get", "/users/" + userId.toString())
           .then((_) => _deserialize(_.data['user']));
  }

  Future<User> update(User updatedUser) {
    return _api.request("put", "/users/" + updatedUser.id.toString(), data: _serialize(updatedUser))
           .then((_) => _deserialize(_.data['user']));
  }

  User _deserialize(map) => new User(id: map['id'], email: map["email"], role: map["role"], password: map['password']);

  String _serialize(User user) {
    var user_map = {
      'user': {
        'email': user.email,
        'roles': [user.role]
      }
    };

    if (user.password != null && user.password.isNotEmpty) {
      user_map['user']['password'] = user.password;
    }

    return JSON.encode(user_map);
  }
}
