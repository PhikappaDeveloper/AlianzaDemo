class User {
  final String id;
  final String username;
  final String password;

  User(
      {this.id = "",
      this.username = "",
      this.password = ""});

  factory User.fromMap(Map<String, dynamic> res) {
    return User(
        id: res["id"],
        username: res["username"],
        password: res["password"]);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password
    };
  }
}
