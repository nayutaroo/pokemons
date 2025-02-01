import 'package:pokemons/model/Pokemon.dart';

import '../api/PokeAPI.dart';

class PokemonUseCase {
  const PokemonUseCase(this._pokeAPI);

  final PokeAPI _pokeAPI;

  Future<List<Pokemon>> getPokemonList({int? offset}) async {
    final pokemonSummaryList = await _pokeAPI.getPokemonList(offset);

    final List<Future<Pokemon>> futurePokemons = pokemonSummaryList.map((summary) {
      return _pokeAPI.getPokemon(summary.name);
    }).toList();

    return await Future.wait(futurePokemons);
  }
}