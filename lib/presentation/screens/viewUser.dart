import 'package:contactapp/presentation/viewmodels/view_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:contactapp/data/models/users.dart';

class ViewUser extends StatelessWidget {
  final ViewUserViewModel viewModel;

  const ViewUser({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts Buddy"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200], // Light background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      Text(
                        "Contact Details",
                        style: TextStyle(
                          fontFamily: 'OpenSans', // Use your custom font
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(width: 60), // Add some spacing
                    ],
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Name',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    viewModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Contact',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    viewModel.contact,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    viewModel.description,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
