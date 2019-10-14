import 'package:sat_s/component.dart';
import 'package:sat_s/user.dart';

class Satellite {
  String id;
  String name;
  List<Component> components;
  SatelliteStatus status;
  DateTime launchDate;
  int cost;
  Duration lifetime;
  String description;
  User owner;

  Satellite(this.id, this.name, this.components, this.status, this.launchDate,
      this.cost, this.lifetime, this.description, this.owner);

//TODO: DATA
}

enum SatelliteStatus {
  ready,
  transportation,
  active,
  lost,
}
