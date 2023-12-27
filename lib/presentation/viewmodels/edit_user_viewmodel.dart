import 'package:contactapp/data/models/users.dart';
import 'package:contactapp/data/services/userService.dart';

class EditUserViewModel {
  final UserService _userService = UserService();

  Future<String> updateUser(
    int id,
    String name,
    String contact,
    String description,
  ) async {
    if (name.isEmpty || contact.isEmpty || description.isEmpty) {
      return 'Validation Error: All fields must be filled';
    }

    var user = Users(
      id: id,
      name: name,
      contact: contact,
      description: description,
    );

    await _userService.UpdateUser(user);
    return 'User details updated successfully!';
  }
}
