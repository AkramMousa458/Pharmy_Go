import 'package:pharmygo/public/models/order_model.dart';

double totalCost({required List<OrderModel> orders}) {
  double totalPrice = 0;
  for (var order in orders) {
    totalPrice += order.totalAmount;
    // for (var drug in order.items) {
    //   totalPrice += drug.price;
    // }
  }
  return totalPrice;
}
