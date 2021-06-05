class Episode {
  late String name;
  late String airDate;
  late String episode;

  Episode({
    required this.name,
    required this.airDate,
    required this.episode,
  });

  Episode.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> episodeInfo = {
      'name': name,
      'air_date': airDate,
      'episode': episode,
    };

    return episodeInfo;
  }
}
