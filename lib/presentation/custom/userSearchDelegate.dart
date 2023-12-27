import 'package:contactapp/data/models/users.dart';
import 'package:flutter/material.dart';

class UserSearchDelegate extends SearchDelegate {
  final List<Users> userList;

  UserSearchDelegate(this.userList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    final filteredList = userList
        .where((user) =>
            user.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(filteredList[index].name ?? ''),
            subtitle: Text(filteredList[index].contact ?? ''),
            onTap: () {
              Navigator.pop(context, filteredList[index]);
            },
          ),
        );
      },
    );
  }
}
