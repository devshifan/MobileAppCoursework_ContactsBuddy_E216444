import 'package:contactapp/data/models/users.dart';
import 'package:contactapp/data/services/userService.dart';

class AddUserViewModel {
  final UserService _userService = UserService();

  Future<String> saveUser(
      String name, String contact, String description) async {
    if (name.isEmpty || contact.isEmpty || description.isEmpty) {
      return 'Validation Error: All fields must be filled';
    }

    var user = Users(
      name: name,
      contact: contact,
      description: description,
    );

    await _userService.SaveUser(user);
    return 'User details saved successfully!';
  }
}
