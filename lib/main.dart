import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon/bloc/bloc/pokemon_bloc.dart';
import 'package:pokemon/data/dio_settings.dart';
import 'package:pokemon/data/pokemon_repo.dart';
import 'package:pokemon/screens/pokemon/pokemon_screen.dart';
import 'package:pokemon/widgets/app_unfocuser.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InitWidget(
      child: AppUnfocuser(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: PokemonScreen(),
        ),
      ),
    );
  }
}

class InitWidget extends StatelessWidget {
  const InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioSettings()),
        RepositoryProvider(
          create: (context) => PokemonRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => PokemonBloc(
                  repo: RepositoryProvider.of<PokemonRepo>(context),
                )..add(
                    GetPokemonEvent(name: ''),
                  )),
          ),
        ],
        child: child,
      ),
    );
  }
}
