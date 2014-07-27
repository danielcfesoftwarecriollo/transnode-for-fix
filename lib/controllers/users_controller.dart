part of transnode;

@Controller(
    selector: '[users-controller]',
    publishAs: 'usersCtrl')
class UsersController {
  List<User> users;
  User user;
  UsersService _usersService;
  RouteProvider _routeProvider;
  MessagesService _messagesService;

  UsersController(this._usersService, this._routeProvider, this._messagesService) {
    if (_routeProvider.routeName == 'users') {
      _usersService.all().then((remote_users) => users = remote_users);
      user = new User(role: 'admin');
    } else {
      _usersService.get(_routeProvider.parameters['userId']).then((_) => user = _);
    }
  }

  void save() {
    _usersService.save(user).then((saved_user) {
      users.add(saved_user);
      _messagesService.add('success', 'User created');
      user = new User(role: 'admin');
    });
  }

  void update() {
    _usersService.update(user).then((updated_user) {
      user = updated_user;
      _messagesService.add('success', 'User updated');
    });
  }

  void delete(user) {
    _usersService.delete(user).then((_) {
      users.remove(user);
      _messagesService.add('success', 'User deleted');
    });
  }
}
