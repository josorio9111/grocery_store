import 'package:flutter/material.dart';
import 'package:grocery_store/grocery_bloc.dart';
import 'package:grocery_store/grocery_list.dart';
import 'package:grocery_store/grocery_provider.dart';

const backgroundColor = Color(0xfff6f5f2);
const cartBarHeigth = 145.0;
const _durationDuration = Duration(milliseconds: 500);

extension on AnimationController {
  void repeatEx({required int times, required VoidCallback cuandoTermine}) {
    var count = 0;
    addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (++count < times) {
          reverse();
        } else {
          cuandoTermine();
        }
      } else if (status == AnimationStatus.dismissed) {
        forward();
      }
    });
  }
}

class GroceryStoreHome extends StatefulWidget {
  const GroceryStoreHome({super.key});

  @override
  State<GroceryStoreHome> createState() => _GroceryStoreHomeState();
}

class _GroceryStoreHomeState extends State<GroceryStoreHome>
    with TickerProviderStateMixin {
  final bloc = GroceryBloc();
  AnimationController? animationController;
  Animation? pulse;
  Animation? move;
  bool display = true;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 1000))
      ..repeatEx(
        times: 3,
        cuandoTermine: () {
          setState(() {
            display = false;
          });
        },
      )
      ..forward();
    // animationController?.repeat(reverse: true);

    pulse = Tween(begin: 2.0, end: 15.0).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });
    move = Tween(begin: 50.0, end: 0.0).animate(animationController!)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _onVerticalGesture(DragUpdateDetails detail) {
    if (detail.primaryDelta! < -7) {
      bloc.changeToCart();
    } else if (detail.primaryDelta! > 12) {
      bloc.changeToNormal();
    }
  }

  double _getTopWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -cartBarHeigth + kToolbarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeigth / 2);
    }
    return 0.0;
  }

  double _getTopBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return size.height - cartBarHeigth;
    } else if (state == GroceryState.cart) {
      return cartBarHeigth / 2;
    }
    return 0.0;
  }

  double _getTopAppBar(GroceryState state) {
    if (state == GroceryState.normal) {
      return 0.0;
    } else if (state == GroceryState.cart) {
      return -cartBarHeigth;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(move?.value);

    return GroceryProvider(
      bloc: bloc,
      child: AnimatedBuilder(
        animation: bloc,
        builder: (BuildContext context, _) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  AnimatedPositioned(
                      duration: _durationDuration,
                      curve: Curves.decelerate,
                      top: _getTopWhitePanel(bloc.groceryState, size),
                      left: 0,
                      right: 0,
                      height: size.height - kToolbarHeight,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        child: GroceryList(),
                      )),
                  AnimatedPositioned(
                      duration: _durationDuration,
                      curve: Curves.decelerate,
                      top: _getTopBlackPanel(bloc.groceryState, size),
                      left: 0,
                      right: 0,
                      height: size.height - cartBarHeigth,
                      child: GestureDetector(
                        onVerticalDragUpdate: _onVerticalGesture,
                        child: Container(
                          color: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AnimatedSwitcher(
                                  duration: _durationDuration,
                                  child: SizedBox(
                                    height: kToolbarHeight,
                                    child: bloc.groceryState ==
                                            GroceryState.normal
                                        ? Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  bloc.changeToCart();
                                                },
                                                child: const Text(
                                                  'Carrito',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              listaCarrito(),
                                              const SizedBox(width: 5),
                                              CircleAvatar(
                                                backgroundColor: Colors.amber,
                                                child: Text(
                                                  '${bloc.totalProduct()}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          )
                                        : Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                bloc.changeToNormal();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 10,
                                                    top: 4,
                                                    bottom: 4),
                                                decoration: BoxDecoration(
                                                    color: Colors.white24,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                // color: Colors.red,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Text('Cerrar',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.amber,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                  )),
                              // Spacer(),
                              // const SizedBox(height: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Carrito',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 15),
                                    _listaCarrritoExpanded(),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total:',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 24),
                                        ),
                                        Text(
                                          '\$${bloc.totalPrecio().toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),

                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.amber)),
                                onPressed: () {},
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    'Pagar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  AnimatedPositioned(
                    duration: _durationDuration,
                    curve: Curves.decelerate,
                    top: _getTopAppBar(bloc.groceryState),
                    left: 0,
                    right: 0,
                    child: const MyAppBar(),
                  ),
                  Positioned(
                      // duration: _durationDuration,
                      // bottom: cartBarHeigth - kToolbarHeight,
                      bottom: kToolbarHeight - move?.value,
                      left: MediaQuery.of(context).size.width / 2 - 20,
                      child: Visibility(
                        visible: display,
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          onTap: () {
                            bloc.changeToCart();
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black87,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.amber.shade200,
                                          blurRadius: pulse?.value,
                                          spreadRadius: pulse?.value)
                                    ]),
                                child: const Icon(
                                  Icons.keyboard_double_arrow_up_outlined,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listaCarrritoExpanded() {
    return Expanded(
      child: ListView.builder(
        itemCount: bloc.cart.length,
        itemBuilder: (context, index) {
          final item = bloc.cart[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: item.product.image,
                ),
                const SizedBox(width: 15),
                Text(
                  item.quatity.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(width: 5),
                const Text(
                  'x',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item.product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                Text(
                  '\$${(item.product.price! * item.quatity).toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      bloc.delProducto(item);
                    },
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.amber,
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded listaCarrito() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              bloc.cart.length,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'list ${bloc.cart[index].product.name}details',
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: bloc.cart[index].product.image,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              bloc.cart[index].quatity.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // const BackButton(color: Colors.black),
          const Expanded(
            child: Text(
              'Grocery Store',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              color: Colors.black)
        ],
      ),
    );
  }
}
