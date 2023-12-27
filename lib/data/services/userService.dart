import 'package:contactapp/utils/database/repository.dart';
import 'package:contactapp/data/models/users.dart';

class UserService {
  late Repository repository;

  UserService() {
    repository = Repository();
  }

//Save User
  SaveUser(Users user) async {
    return await repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await repository.readData('users');
  }

  //Edit User
  UpdateUser(Users user) async {
    return await repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async {
    return await repository.deleteDataById('users', userId);
  }
}
