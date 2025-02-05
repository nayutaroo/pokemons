
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pokemons/model/pokemon.dart';
import 'package:pokemons/widget/detail_page.dart';
import 'package:pokemons/widget/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: DetailRoute.page),
  ];
}
