import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/controller/Products.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          GetBuilder<Products>(builder: (items) {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.cartList.length,
                    itemBuilder: (ctx, index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          items.removeItem(items.cartList[index].value.id,
                              items.cartList[index].value.price);
                        },
                        key: Key(
                          UniqueKey().toString(),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(2, 3))
                              ],
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              Image.asset(
                                items.cartList[index].value.img,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  items.cartList[index].value.title,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Rs ${items.cartList[index].value.price.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                Text(
                  'Total price: ${items.sum.value.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton(
                    onPressed: items.sum.value.isGreaterThan(0)
                        ? () {
                            ScaffoldMessenger.of(context).showMaterialBanner(
                                MaterialBanner(
                                    leading: Icon(Icons.add_shopping_cart),
                                    content: const Text(
                                        'Your Order accepted successfully'),
                                    actions: [
                                  TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner();
                                      },
                                      child: Text('Ok'))
                                ]));
                          }
                        : null,
                    child: const Text('Checkout'))
              ],
            );
          })
        ],
      ),
    );
  }
}
