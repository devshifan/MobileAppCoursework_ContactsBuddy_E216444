import 'package:contactapp/presentation/viewmodels/edit_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:contactapp/data/models/users.dart';

class EditUser extends StatefulWidget {
  final Users users;
  // ignore: use_key_in_widget_constructors
  const EditUser({Key? key, required this.users});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();
  var _validateName = false;
  var _validateContact = false;
  var _validateDescription = false;
  final _editUserViewModel = EditUserViewModel();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.users.name ?? '';
      _userContactController.text = widget.users.contact ?? '';
      _userDescriptionController.text = widget.users.description ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts Buddy"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEFEFEF), Color(0xFFFFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Edit User',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter Name',
                        errorText:
                            _validateName ? 'Name Value Can\'t Be Empty' : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _userContactController,
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        hintText: 'Enter Contact',
                        errorText: _validateContact
                            ? 'Contact Value Can\'t Be Empty'
                            : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _userDescriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter Description',
                        errorText: _validateDescription
                            ? 'Description Value Can\'t Be Empty'
                            : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userContactController.text.isEmpty
                              ? _validateContact = true
                              : _validateContact = false;
                          _userDescriptionController.text.isEmpty
                              ? _validateDescription = true
                              : _validateDescription = false;
                        });
                        if (!_validateName &&
                            !_validateContact &&
                            !_validateDescription) {
                          var result = await _editUserViewModel.updateUser(
                            widget.users.id ??
                                0, // Use a default value if id is null
                            _userNameController.text,
                            _userContactController.text,
                            _userDescriptionController.text,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, result);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.lightBlueAccent, // Lighter blue color
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      child: const Text(
                        'Update Details',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        backgroundColor: const Color.fromARGB(
                            255, 167, 166, 166), // Light grey color
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      child: const Text(
                        'Clear Details',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
