import 'package:kowoerka/model/user.dart';

class UserRepository {
  List<User> _users;

  List<User> get users => _users;

  UserRepository(this._users);
}
