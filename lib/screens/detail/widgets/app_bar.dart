part of '../detail_screen.dart';

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  _AppBar({
    Key? key,
    required this.name,
  }) : super(key: key);

  TextEditingController search = TextEditingController();
  final String name;
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
               Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(225);
}
