import 'package:assignment_06/logic/cubits/episode_data/episode_data_cubit.dart';
import 'package:assignment_06/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Episodes extends StatelessWidget {
  static const routeName = '/episodes';
  final List<dynamic> episodes;

  const Episodes({
    Key? key,
    required this.episodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: episodes.first.length,
        itemBuilder: (context, index) {
          var episodeUrl = episodes.first[index];

          final episodeId = int.parse((episodeUrl as String).split('/').last);
          final int season = _getSeason(episodeId);

          return ListTile(
            onTap: () {
              BlocProvider.of<EpisodeDataCubit>(context).emit(
                EpisodeDataInitial(),
              );

              BlocProvider.of<EpisodeDataCubit>(context).getEpisodeData(
                episodeId,
              );

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Episode Details',
                      textAlign: TextAlign.center,
                    ),
                    content: BlocBuilder<EpisodeDataCubit, EpisodeDataState>(
                      builder: (context, state) {
                        if (state is EpisodeDataInitial) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (state is EpisodeDataLoaded) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.episode.episode),
                              Text(
                                state.episode.name,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Air Date: ${state.episode.airDate}',
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  (state as EpisodeDataError).message,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            title: Text('Season $season - Episode id #$episodeId'),
            leading: const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/placeholders/placeholder.png'),
            ),
          );
        },
      ),
    );
  }

  int _getSeason(int episodeId) {
    if (episodeId <= firstSeasonEnd) {
      return 1;
    } else if (episodeId <= secondSeasonEnd) {
      return 2;
    } else if (episodeId <= thirdSeasonEnd) {
      return 3;
    } else if (episodeId <= fourthSeasonEnd) {
      return 4;
    } else {
      return 5;
    }
  }
}
