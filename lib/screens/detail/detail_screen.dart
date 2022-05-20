import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon/data/pokemon_repo.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/resources/app_colors.dart';
import 'package:pokemon/resources/images/images.dart';

import '../../bloc/bloc/pokemon_bloc.dart';

part 'widgets/app_bar.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final name = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: ValueListenableBuilder(
            valueListenable: name,
            builder: (context, a, b) {
              return _AppBar(
                name: name.value,
              );
            }),
      ),
      backgroundColor: AppColors.color372323,
      body: BlocProvider.value(
        value: PokemonBloc(repo: RepositoryProvider.of<PokemonRepo>(context))
          ..add(GetDetailPokemonEvent(id: widget.id)),
        child: BlocConsumer<PokemonBloc, PokemonState>(
          listener: (context, state) {
            if (state is PokemonSuccessState) {
              name.value = state.detail.name ?? '';
            }
          },
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is PokemonSuccessState) {
              return DefaultTabBar(
                model: state.detail,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class DefaultTabBar extends StatefulWidget {
  const DefaultTabBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PokemonDetailModel model;

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220,
            child: TabBar(
                indicator: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 4, color: Colors.white),
                  ),
                ),
                indicatorPadding: const EdgeInsets.all(6),
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'Stats',
                  ),
                  Tab(text: 'Evolution'),
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.model.status ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.model.gender ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        widget.model.location?.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('text')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
