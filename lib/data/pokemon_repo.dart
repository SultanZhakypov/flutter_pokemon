import 'package:dio/dio.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/models/pokemon_model.dart';

class PokemonRepo {
  PokemonRepo({required this.dio});
  final Dio dio;

  Future<PokemonResponse> getPokemons(
      {required String name, required int pageNumber}) async {
    final result = await dio
        .get('character', queryParameters: {'name': name, 'page': pageNumber});

    return PokemonResponse.fromJson(result.data);
  }

  Future<PokemonDetailModel> getDetailPokemon({required int id}) async {
    final result = await dio.get('character/$id');

    return PokemonDetailModel.fromJson(result.data);
  }
}
