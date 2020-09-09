class User{
  final String name;
  final String email;
  final String token;
  final String userId;
  final bool isAdmin;
  final DateTime expireDate;

  User(this.name, this.email, this.token, this.userId, this.isAdmin, this.expireDate);

//  static User fromJson(map)=> User(map['name'], map['email'], map['id'], map['isAdmin']);

}