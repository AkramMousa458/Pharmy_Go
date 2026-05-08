import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/patient/cubits/get_cart/get_cart_cubit.dart';
import 'package:pharmygo/patient/widgets/custom_cart_item.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomCartListWidget extends StatelessWidget {
  const CustomCartListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCartCubit, GetCartState>(
      builder: (context, state) {
        if (state is GetCartFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is GetCartSuccsess) {
          return state.ordersList.isEmpty
              ? const Center(
                  child: Text('There is no Orders!'),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.ordersList.length,
                  itemBuilder: (context, index) =>
                      CustomCartItem(orderModel: state.ordersList[index]),
                );
        } else {
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
      },
    );
  }
}
