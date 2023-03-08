import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_product.dart';

enum GroceryState { normal, detail, cart }

class GroceryBloc extends ChangeNotifier {
  GroceryState groceryState = GroceryState.normal;
  List<GroceryProduct> catalogo = List.unmodifiable(groceryProducts);
  List<GroceryProductItem> cart = [];

  void changeToNormal() {
    groceryState = GroceryState.normal;
    notifyListeners();
  }

  void changeToCart() {
    groceryState = GroceryState.cart;
    notifyListeners();
  }

  void addProduct(GroceryProduct product) {
    for (GroceryProductItem item in cart) {
      if (item.product.name == product.name) {
        item.increment();
        notifyListeners();
        return;
      }
    }
    cart.add(GroceryProductItem(product: product));
    notifyListeners();
  }

  void delProducto(GroceryProductItem item) {
    if (item.quatity == 1) {
      cart.remove(item);
      notifyListeners();
      return;
    }
    item.decreement();
    notifyListeners();
    return;
  }

  int totalProduct() =>
      cart.fold(0, (previousValue, element) => previousValue + element.quatity);

  double totalPrecio() => cart.fold(
      0,
      (previousValue, element) =>
          previousValue + element.product.price! * element.quatity);
}

class GroceryProductItem {
  int quatity;
  final GroceryProduct product;

  GroceryProductItem({this.quatity = 1, required this.product});

  void increment() {
    quatity++;
  }

  void decreement() {
    quatity--;
  }
}
