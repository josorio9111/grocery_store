import 'package:flutter/material.dart';

class GroceryProduct {
  const GroceryProduct(
      {this.name, this.price, this.desc, this.image, this.weith});
  final String? name;
  final double? price;
  final String? desc;
  final FlutterLogo? image;
  final String? weith;
}

const groceryProducts = <GroceryProduct>[
  GroceryProduct(
      name: 'Bannana',
      desc: 'bannana desc',
      image: FlutterLogo(),
      price: 8.20,
      weith: '500g'),
  GroceryProduct(
      name: 'Mango',
      desc: 'Mango desc',
      image: FlutterLogo(),
      price: 2.20,
      weith: '1000g'),
  GroceryProduct(
      name: 'Bannana 1',
      desc: 'bannana desc',
      image: FlutterLogo(),
      price: 5.20,
      weith: '500g'),
  GroceryProduct(
      name: 'Bannana 2',
      desc: 'bannana desc',
      image: FlutterLogo(),
      price: 1.20,
      weith: '500g'),
  GroceryProduct(
      name: 'Mango 1',
      desc: 'Mango desc',
      image: FlutterLogo(),
      price: 9.20,
      weith: '1000g'),
  GroceryProduct(
      name: 'Bannana 3',
      desc: 'bannana desc',
      image: FlutterLogo(),
      price: 0.20,
      weith: '500g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
  // GroceryProduct(
  //     name: 'Mango',
  //     desc: 'Mango desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '1000g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
  // GroceryProduct(
  //     name: 'Mango',
  //     desc: 'Mango desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '1000g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
  // GroceryProduct(
  //     name: 'Mango',
  //     desc: 'Mango desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '1000g'),
  // GroceryProduct(
  //     name: 'Bannana',
  //     desc: 'bannana desc',
  //     image: FlutterLogo(),
  //     price: 8.20,
  //     weith: '500g'),
];
