import 'package:assignment_06/data/models/episode.dart';
import 'package:assignment_06/data/repositories/episode_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'episode_data_state.dart';

class EpisodeDataCubit extends Cubit<EpisodeDataState> {
  EpisodeDataCubit() : super(EpisodeDataInitial());

  final episodeRepository = EpisodeRepository();

  Future<void> getEpisodeData(int episodeId) async {
    try {
      var episode = await episodeRepository.fetchEpisode(episodeId);

      emit(EpisodeDataLoaded(
        episode: episode!,
      ));
    } catch (e) {
      emit(EpisodeDataError(
        message: e.toString(),
      ));
    }
  }
}
