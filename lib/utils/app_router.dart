import 'package:flutter/cupertino.dart';

abstract class AppRouter {
  static void push(BuildContext? context, Widget screen) {
    if (context == null) return;
    Navigator.of(context).push(FadeRoute(page: screen));
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({
    required this.page,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
