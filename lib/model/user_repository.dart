import 'package:kowoerka/model/user.dart';

class UserRepository {
  List<User> _users;

  List<User> get users => _users;

  UserRepository(this._users);

  /// return: no login feature implemented yet so just returns the first user
  User getLoggedInUser() {
    return _users.first;
  }
}
