import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/screens/cart_screen.dart';

import '../controller/Products.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final Products _products = Get.put(Products());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flower Pots'),
        actions: [
          Stack(
            children: [
              Obx(
                () => IconButton(
                    onPressed: _products.cartList.isEmpty
                        ? null
                        : () {
                            Get.to(() => CartScreen());
                          },
                    icon: const Icon(Icons.shopping_cart_outlined)),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.8)),
                  child: Obx(() => Text(
                        _products.cartList.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ))),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: _products.products.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, mainAxisExtent: 180),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(1, 2))
                    ]),
                child: Column(
                  children: [
                    Image.asset(
                      _products.products[index].value.img,
                      fit: BoxFit.cover,
                      height: 80,
                      width: double.infinity,
                    ),
                    Text(_products.products[index].value.title),
                    Text(
                      "Rs ${_products.products[index].value.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Obx(() => _products.products[index].value.inCart.isFalse
                        ? ElevatedButton(
                            onPressed: () {
                              _products
                                  .addItem(_products.products[index].value.id);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      '${_products.products[index].value.title} Added')));
                              _products.totalPrice(
                                  _products.products[index].value.price);

                              // if (_products
                              //     .products[index].value.inCart.isFalse) {
                              //   _products.addItem(
                              //       _products.products[index].value.id);
                              // } else {
                              //   _products.removeItem(
                              //       _products.products[index].value.id);
                              // }
                            },
                            child: const Text('Add to cart'))
                        : const Icon(Icons.done))
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
