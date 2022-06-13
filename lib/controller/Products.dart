import 'package:get/get.dart';
import 'dart:math';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/products.dart';

class Products extends GetxController {
  RxDouble sum = 0.0.obs;
  final List<Rx<Product>> products = [
    Product(
            id: 1,
            title: 'Flower pot 1',
            img: 'assets/images/img1.jpg',
            price: Random().nextDouble() * 100,
            inCart: false.obs)
        .obs,
    Product(
            id: 2,
            title: 'Flower pot 2',
            img: 'assets/images/img2.jpg',
            price: Random().nextDouble() * 100,
            inCart: false.obs)
        .obs,
    Product(
            id: 3,
            title: 'Flower pot 3',
            img: 'assets/images/img3.jpg',
            price: Random().nextDouble() * 100,
            inCart: false.obs)
        .obs,
    Product(
            id: 4,
            title: 'Flower pot 4',
            img: 'assets/images/img4.jpg',
            price: Random().nextDouble() * 100,
            inCart: false.obs)
        .obs,
    Product(
            id: 5,
            title: 'Flower pot 5',
            img: 'assets/images/img5.jpeg',
            price: Random().nextDouble() * 100,
            inCart: false.obs)
        .obs
  ];
  List<Rx<Product>> get cartList {
    return products
        .where((product) => product.value.inCart.value == true)
        .toList();
  }

  void addItem(int id) {
    final int index = products.indexWhere((item) => item.value.id == id);
    products[index].value.inCart.value = true;
  }

  void removeItem(
    int id,
    double price,
  ) {
    final int index = products.indexWhere((item) => item.value.id == id);
    products[index].value.inCart.value = false;
    removeTotalPrice(price);
  }

  void totalPrice(price) {
    sum = sum + price as RxDouble;
    update();
  }

  void removeTotalPrice(price) {
    sum = sum - price as RxDouble;
    update();
  }
}
