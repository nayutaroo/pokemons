import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemons/provider/PokemonProvider.dart';

class PokemonGrid extends HookConsumerWidget {
  const PokemonGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonState = ref.watch(pokemonProvider);

    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        final pokemonNotifier = ref.read(pokemonProvider.notifier);
        pokemonNotifier.loadMorePokemons();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモンリスト'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: pokemonState.pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemonState.pokemons[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          pokemon.imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('画像が見つかりません'));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (pokemonState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16), // 上下の余白を追加
                child: Center(
                  child: CircularProgressIndicator(), // ローディングインジケータ
                ),
              ),
          ],
        ),
      ),
    );
  }
}