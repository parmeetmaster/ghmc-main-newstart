import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder({
    RouteSettings? settings,
    required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 0),
    this.reverseTransitionDuration = const Duration(milliseconds: 0),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            pageBuilder: pageBuilder,
            barrierColor: barrierColor,
            barrierDismissible: barrierDismissible,
            barrierLabel: barrierLabel,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            opaque: opaque,
            reverseTransitionDuration: reverseTransitionDuration,
            settings: settings,
            transitionDuration: transitionDuration,
            transitionsBuilder: transitionsBuilder);

  @override
  final RoutePageBuilder pageBuilder;

  @override
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;
}

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return child;
}
