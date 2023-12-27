import 'package:contactapp/presentation/custom/userSearchDelegate.dart';
import 'package:contactapp/data/models/users.dart';
import 'package:contactapp/presentation/screens/addUser.dart';
import 'package:contactapp/presentation/screens/editUser.dart';
import 'package:contactapp/presentation/screens/viewUser.dart';
import 'package:contactapp/data/services/userService.dart';
import 'package:contactapp/presentation/viewmodels/view_user_viewmodel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shifan Samsudeen (E216444) - Mobile Application Coursework',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Users> _userList;
  final _userService = UserService();
  final TextEditingController _searchController = TextEditingController();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <Users>[];
    users.forEach((user) {
      setState(() {
        var userModel = Users();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];

        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    _userList = <Users>[]; // Initialize the list in initState
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _onDeleteConfirmation(BuildContext context, int userId) async {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Are You Sure to Delete?',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          content: const Text(
            'This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 221, 135, 129),
              ),
              onPressed: () async {
                var result = await _userService.deleteUser(userId);
                if (result != null) {
                  Navigator.pop(context);
                  getAllUserDetails();
                  _showSuccessSnackBar('User Detail Deleted Successfully');
                }
              },
              child: const Text('Delete'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts Buddy"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(_userList),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200], // Background color for the ListView
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            Users user = _searchController.text.isEmpty
                ? _userList[index]
                : _userList
                    .where((user) =>
                        user.name
                            ?.toLowerCase()
                            .contains(_searchController.text.toLowerCase()) ??
                        false)
                    .toList()[index];

            return Card(
              elevation: 4, // Add elevation for a card-like look
              margin: const EdgeInsets.all(8),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewUser(
                        viewModel: ViewUserViewModel(users: user),
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.person),
                title: Text(user.name ?? ''),
                subtitle: Text(user.contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUser(
                              users: user,
                            ),
                          ),
                        ).then((value) {
                          if (value != null) {
                            getAllUserDetails();
                            _showSuccessSnackBar(
                                'User details Updated successfully!');
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.teal,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _onDeleteConfirmation(context, user.id!);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 221, 135, 129),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Coursework Mobile Application - E216444",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUser()),
            ).then((value) {
              if (value != null) {
                getAllUserDetails();
                _showSuccessSnackBar('User details added successfully!');
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
