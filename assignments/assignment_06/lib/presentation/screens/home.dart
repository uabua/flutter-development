import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_06/data/models/character.dart';
import 'package:assignment_06/logic/cubits/character_data_cubit.dart';
import 'package:assignment_06/presentation/screens/episodes.dart';
import 'package:assignment_06/widgets/character_item.dart';
import 'package:pagination_view/pagination_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
      ),
      body: BlocConsumer<CharacterDataCubit, CharacterDataState>(
        builder: (context, state) {
          if (state is CharacterDataInitial) {
            BlocProvider.of<CharacterDataCubit>(context).getCharacterData();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharacterDataLoaded) {
            return PaginationView<Character>(
              itemBuilder:
                  (BuildContext context, Character character, int index) {
                return GestureDetector(
                  child: CharacterItem(
                    image: character.image,
                    name: character.name,
                    status: character.status,
                    species: character.species,
                    type: character.type,
                    gender: character.gender,
                    origin: character.origin.name,
                    location: character.location.name,
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Episodes.routeName,
                    arguments: character.episodes,
                  ),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(character.name),
                    ),
                  ),
                );
              },
              pageFetch: (currentListSize) async {
                final characterCubit =
                    BlocProvider.of<CharacterDataCubit>(context);

                if (characterCubit.page < 35) {
                  characterCubit.page++;

                  await characterCubit.getCharacterData(
                    page: characterCubit.page - 1,
                  );

                  return (characterCubit.state as CharacterDataLoaded)
                      .characters;
                }

                return [];
              },
              onError: (dynamic error) => const Center(
                child: Text('Some error occured'),
              ),
              onEmpty: const Center(
                child: Text('Sorry! This is empty'),
              ),
              bottomLoader: const Center(
                // optional
                child: CircularProgressIndicator(),
              ),
              initialLoader: const Center(
                // optional
                child: CircularProgressIndicator(),
              ),
            );

            // return ListTile(
            //   onTap: () => Navigator.pushNamed(
            //     context,
            //     CharacterDetails.routeName,
            //     arguments: index,
            //   ),
            //   title: Text(character.name),
            //   leading: CircleAvatar(
            //     backgroundImage: NetworkImage(
            //       character.image,
            //     ),
            //     backgroundColor: Colors.transparent,
            //   ),
            // );
            // },
            // );
          } else {
            return const Center(
              child: Text('Ops! Something went wrong!'),
            );
          }
        },
        listener: (context, state) {
          if (state is CharacterDataError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
