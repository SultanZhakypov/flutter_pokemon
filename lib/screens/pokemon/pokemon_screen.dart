import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pokemon/bloc/bloc/pokemon_bloc.dart';
import 'package:pokemon/models/pokemon_model.dart';
import 'package:pokemon/resources/app_colors.dart';
import 'package:pokemon/resources/images/images.dart';
import 'package:pokemon/resources/images/svgs.dart';
import 'package:pokemon/screens/detail/detail_screen.dart';
import 'package:pokemon/utils/app_router.dart';
import 'package:pokemon/widgets/text_fields/default_textfield.dart';

part 'widgets/app_bar.dart';
part 'widgets/pokemon_item.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color372323,
      appBar: _AppBar(),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is PokemonSuccessState) {
            return SuccessBody(
              models: state.models,
              isLoading: state.isLoading,
            );
          }
          if (state is PokemonErrorState) {
            return Center(
              child: Image.network(
                  'https://purepng.com/public/uploads/large/purepng.com-pokemonpokemonpocket-monsterspokemon-franchisefictional-speciesone-pokemonmany-pokemonone-pikachu-1701527785361ae5to.png'),
            );
          }
          return const Text('Пусто');
        },
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.models, required this.isLoading})
      : super(key: key);

  final List<Results> models;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    bool nextPage = isLoading;
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        final current = notification.metrics.pixels + 100;
        final max = notification.metrics.maxScrollExtent;
        if (current >= max && !nextPage) {
          nextPage = true;
          BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent());
        }
        return true;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => AppRouter.push(
            context,
            DetailScreen(id: models[index].id ?? 0),
          ),
          child: PokemonItem(
            name: models[index].name ?? '',
            image: models[index].image ?? '',
          ),
        ),
        separatorBuilder: (context, separator) => const SizedBox(
          height: 12,
        ),
        itemCount: models.length,
      ),
    );
  }
}
