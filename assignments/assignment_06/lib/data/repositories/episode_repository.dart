import 'package:assignment_06/data/models/episode.dart';
import 'package:dio/dio.dart';

class EpisodeRepository {
  late Episode episode;
  Dio dio = Dio();

  Future<Episode?> fetchEpisode(int episodeId) async {
    final response = await dio.get(
      "https://rickandmortyapi.com/api/episode/$episodeId",
    );

    if (response.statusCode == 200) {
      episode = Episode.fromJson(response.data);

      return episode;
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
