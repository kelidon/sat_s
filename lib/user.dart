import 'package:sat_s/satellite.dart';

class User {
  String id;
  String name;
  String password;
  List<Satellite> satellites;
  List<User> friends;
  int wallet;

  User(this.id, this.name, this.password, this.satellites, this.friends,
      this.wallet);
}
