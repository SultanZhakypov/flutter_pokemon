import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:pokemon/data/pokemon_repo.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/models/pokemon_model.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({
    required this.repo,
  }) : super(PokemonInitialState()) {
    on<GetPokemonEvent>((event, emit) async {
      emit(
        PokemonSuccessState(
          models: allCharacters,
          isLoading: true,
          detail: PokemonDetailModel(),
        ),
      );
      try {
        final result = await repo.getPokemons(
            name: event.name ?? '', pageNumber: pageNumber);
        allCharacters.addAll(result.results ?? []);
        maxPage = result.info?.pages ?? 1;
        pageNumber++;
        emit(
          PokemonSuccessState(
            models: allCharacters,
            isLoading: false,
            detail: PokemonDetailModel(),
          ),
        );
      } catch (e) {
        emit(PokemonErrorState(models: allCharacters));
      }
    });
    on<GetDetailPokemonEvent>((event, emit) async {
      emit(
        PokemonLoadingState(
          models: const [],
          
        ),
      );
      try {
        final result = await repo.getDetailPokemon(id: event.id);
        emit(
          PokemonSuccessState(
            models: const [],
            isLoading: false,
            detail: result,
          ),
        );
      } catch (e) {
        emit(PokemonErrorState(models: allCharacters));
      }
    });
  }
  int maxPage = 1;
  int pageNumber = 1;
  List<Results>  allCharacters = [];

  final PokemonRepo repo;
}

@immutable
abstract class PokemonEvent {}

class GetPokemonEvent extends PokemonEvent {
  GetPokemonEvent({
    this.name,
  });
  final String? name;
}

class GetDetailPokemonEvent extends PokemonEvent {
  GetDetailPokemonEvent({
    required this.id,
  });
  final int id;
}

@immutable
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {
  final List<Results> models;
  PokemonLoadingState({
    required this.models,
  });
}

class PokemonSuccessState extends PokemonState {
  PokemonSuccessState({
    required this.models,
    required this.detail,
    required this.isLoading,
  });
  final List<Results> models;
  final PokemonDetailModel detail;
  final bool isLoading;
}

class PokemonErrorState extends PokemonState {
  final List<Results> models;
  PokemonErrorState({
    required this.models,
  });
}
