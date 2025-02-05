import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemons/foundation/hooks/l10n.dart';
import 'package:pokemons/foundation/hooks/theme.dart';
import 'package:pokemons/model/pokemon.dart';

@RoutePage()
final class DetailPage extends HookConsumerWidget {
  final Pokemon pokemon;

  const DetailPage({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = useTheme();

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text(l10n.errorImageText));
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              pokemon.name, // ポケモンの説明テキスト
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
