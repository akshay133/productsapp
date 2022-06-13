import 'package:get/get.dart';

class Product {
  int id;
  String title;
  String img;
  double price;
  RxBool inCart;
  Product(
      {required this.id,
      required this.title,
      required this.img,
      required this.price,
      required this.inCart});
}
