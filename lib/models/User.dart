class User{
  final String name;
  final String email;
  final String id;

  final bool isAdmin;

  User(this.name, this.email, this.id, this.isAdmin);

//  static User fromJson(map)=> User(map['name'], map['email'], map['id'], map['isAdmin']);

}