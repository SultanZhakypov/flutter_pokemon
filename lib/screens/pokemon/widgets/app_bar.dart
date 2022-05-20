part of '../pokemon_screen.dart';


class _AppBar extends StatelessWidget with PreferredSizeWidget {
  _AppBar({Key? key}) : super(key: key);

  TextEditingController search = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.color372323,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Images.pokemonTitle,
                width: double.infinity,
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                'Pokemon list',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Find the pokemon you want',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Flexible(
                    child: DefaultTextField(inSearch: search),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<PokemonBloc>(context)
                            .add(GetPokemonEvent(name: search.text));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(6),
                        primary: AppColors.color43403F,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: SvgPicture.asset(
                        Svgs.vector,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250);
}
