class Location {
  late String name;

  Location({
    required this.name,
  });

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> locationName = {
      'name': name,
    };

    return locationName;
  }
}
