class Users {
  int? id;
  String? name;
  String? contact;
  String? description;

  // Constructor
  Users({
    this.id,
    this.name,
    this.contact,
    this.description,
  });

  // Method to convert User object to a map
  Map<String, dynamic> userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name ?? '';
    mapping['contact'] = contact ?? '';
    mapping['description'] = description ?? '';
    return mapping;
  }
}
