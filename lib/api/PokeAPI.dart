import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/Pokemon.dart';
import '../model/PokemonSummary.dart';

class PokeAPI {
  Future<List<PokemonSummary>> getPokemonList(int? offset) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=21'));

    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);
      final results = data['results'];
      return results.map<PokemonSummary>((json) => PokemonSummary(json['name'])).toList();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<Pokemon> getPokemon(String name) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$name'));
    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);
      return Pokemon(
        id: data['id'].toString(),
        name: data['name'],
        imageUrl: data['sprites']['front_default'],
      );

    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}