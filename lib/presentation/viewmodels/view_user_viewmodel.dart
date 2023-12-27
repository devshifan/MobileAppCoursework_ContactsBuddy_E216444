import 'package:contactapp/data/models/users.dart';

class ViewUserViewModel {
  final Users users;

  ViewUserViewModel({required this.users});

  String get name => users.name ?? '';
  String get contact => users.contact ?? '';
  String get description => users.description ?? '';
}
