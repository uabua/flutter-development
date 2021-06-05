import 'package:assignment_06/data/models/location.dart';

class Character {
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late Location origin;
  late Location location;
  late String image;
  late List<dynamic> episodes;

  Character({
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodes,
  });

  Character.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = Location.fromJson(json['origin']);
    location = Location.fromJson(json['location']);
    image = json['image'];
    episodes = json['episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> characterInfo = {
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
      'episode': episodes,
    };

    return characterInfo;
  }
}
