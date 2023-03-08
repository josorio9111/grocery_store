import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_detail.dart';
import 'package:grocery_store/grocery_provider.dart';
import 'package:grocery_store/home.dart';
import 'package:grocery_store/stagge_view.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = GroceryProvider.of(context)!.bloc;
    return Container(
      padding: const EdgeInsets.only(top: cartBarHeigth, left: 10, right: 10),
      color: backgroundColor,
      child: StaggeDualView(
          spacing: 10,
          aspectRatio: 0.7,
          itemCount: bloc.catalogo.length,
          itemBuilder: (context, index) {
            final product = bloc.catalogo[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 750),
                  pageBuilder: (context, animation, _) {
                    return FadeTransition(
                        opacity: animation,
                        child: GroceryDetail(
                            product: product,
                            onProductAdded: () {
                              bloc.addProduct(product);
                            }));
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 8,
                shadowColor: Colors.black45,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: 'list ${product.name}',
                          child: SizedBox(
                              width: 130, height: 130, child: product.image!)),
                      Text(
                        product.price!.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        product.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        product.weith.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
