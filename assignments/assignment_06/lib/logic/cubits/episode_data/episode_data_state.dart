part of 'episode_data_cubit.dart';

abstract class EpisodeDataState extends Equatable {
  const EpisodeDataState();
}

class EpisodeDataInitial extends EpisodeDataState {
  @override
  List<Object> get props => [];
}

class EpisodeDataLoaded extends EpisodeDataState {
  final Episode episode;

  const EpisodeDataLoaded({
    required this.episode,
  });

  @override
  List<Object?> get props => [episode];
}

class EpisodeDataError extends EpisodeDataState {
  final String message;

  const EpisodeDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
