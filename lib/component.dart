import 'package:sat_s/satellite.dart';

class Component {
  String id;
  String name;
  int mass;
  Duration lifetime;
  int cost;
  String description;
  List<Satellite> equipped;

  Component(this.name, this.mass, this.lifetime, this.cost, this.description,
      this.equipped);
}

enum ComponentStatus {
  active,
  lost,
}
