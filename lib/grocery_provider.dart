import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_bloc.dart';

class GroceryProvider extends InheritedWidget {
  final GroceryBloc bloc;
  final Widget child;

  const GroceryProvider({
    super.key,
    required this.bloc,
    required this.child,
  }) : super(child: child);

  static GroceryProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<GroceryProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
