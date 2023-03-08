import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_product.dart';

class GroceryDetail extends StatefulWidget {
  final GroceryProduct product;
  final VoidCallback onProductAdded;
  const GroceryDetail(
      {super.key, required this.product, required this.onProductAdded});

  @override
  State<GroceryDetail> createState() => _GroceryDetailState();
}

class _GroceryDetailState extends State<GroceryDetail> {
  String hero = '';

  void _addCart(BuildContext context) {
    setState(() {
      hero = 'details';
    });
    widget.onProductAdded();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: 'list ${widget.product.name}$hero',
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.36,
                          child: widget.product.image),
                    ),
                    Text(widget.product.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26)),
                    const SizedBox(height: 5),
                    Text(widget.product.weith.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Spacer(),
                        Text('\$${widget.product.price!.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 33)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('About the product',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(widget.product.desc.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border)),
                  ),
                  Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () {
                          _addCart(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Add to Card',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
