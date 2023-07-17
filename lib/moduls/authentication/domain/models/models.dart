class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  User(this.id, this.firstName, this.lastName, this.email, this.phone);
}

class Login {
  User? user;
  Login(this.user);
}
