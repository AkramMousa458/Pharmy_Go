import 'package:flutter/material.dart';
import 'package:pharmygo/patient/widgets/custom_order_info.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/models/order_model.dart';

class CustomOrderProducsCard extends StatelessWidget {
  const CustomOrderProducsCard({
    super.key,
    required this.title,
    required this.ordersList,
    required this.onPressed,
  });

  final String title;
  final List<OrderModel> ordersList;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ThemeColors.kLightGreyColor(context),
        border: Border.all(color: ThemeColors.kGreyColor(context)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeColors.kMainColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // CustomEditButton(text: 'Edit', onPressed: onPressed),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ordersList.length,
            itemBuilder: (context, index) => CustomOrderInfo(
              orderModel: ordersList[index],
            ),
          )
        ],
      ),
    );
  }
}
