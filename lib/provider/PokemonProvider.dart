import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/PokeAPI.dart';
import '../model/Pokemon.dart';
import '../usecase/PokemonListUseCase.dart';

class PokemonState {
  final List<Pokemon> pokemons;
  final bool isLoading;

  PokemonState({required this.pokemons, required this.isLoading});
}

class PokemonNotifier extends StateNotifier<PokemonState>{
  PokemonNotifier() : super(PokemonState(pokemons: [], isLoading: false));

  void loadPokemons() {
    if (state.isLoading) return;

    state = PokemonState(pokemons: state.pokemons, isLoading: true);

    final pokemonUseCase = PokemonUseCase(PokeAPI());
    pokemonUseCase.getPokemonList(offset: null).then((pokemons) {
      state = PokemonState(pokemons: pokemons, isLoading: false);
    }).catchError((error) {
      print("Error loading pokemons: $error");
      state = PokemonState(pokemons: state.pokemons, isLoading: false);
    });
  }

  void loadMorePokemons() {
    if (state.isLoading) return;

    state = PokemonState(pokemons: state.pokemons, isLoading: true);

    final pokemonUseCase = PokemonUseCase(PokeAPI());
    pokemonUseCase.getPokemonList(offset: state.pokemons.length).then((pokemons) {
      state = PokemonState(pokemons: [...state.pokemons, ...pokemons], isLoading: false);
    }).catchError((error) {
      print("Error loading pokemons: $error");
      state = PokemonState(pokemons: state.pokemons, isLoading: false);
    });
  }
}

// Providerを定義
final pokemonProvider = StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  return PokemonNotifier()..loadPokemons();
});