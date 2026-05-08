import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/pharmacist/cubits/get_pharmacy_orders/get_pharmacy_orders_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/order_item.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class MyMedicinesListViewBuilder extends StatelessWidget {
  const MyMedicinesListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPharmacyOrdersCubit, GetPharmacyOrdersState>(
      builder: (context, state) {
        if (state is GetPharmacyOrdersFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is GetPharmacyOrdersSuccsess) {
          return state.ordersList.isEmpty
              ? const Center(
                  child: Text('There is no Orders!'),
                )
              : ListView.builder(
                  itemCount: state.ordersList.length,
                  itemBuilder: (context, index) {
                    return OrderItem(
                      pharmacyOrderModel: state.ordersList[index],
                    );
                  },
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
