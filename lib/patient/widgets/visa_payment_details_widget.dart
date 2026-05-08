import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/patient/cubits/paymob_manager_cubit/paymob_manager_cubit.dart';
import 'package:pharmygo/patient/views/checkout_order_view.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class VisaPayDetailsWidget extends StatelessWidget {
  const VisaPayDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return BlocConsumer<PaymobManagerCubit, PaymobManagerState>(
      listener: (context, state) async {
        if (state is PaymobManagerFailure) {
          log(state.errMessage);
          isLoading = false;
        } else if (state is PaymobManagerSusccsess) {
          isLoading = false;
        } else {
          isLoading = true;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 160),
          child: CustomButton(
            text: 'Pay',
            isLoading: isLoading,
            onPressed: () async {
              await _pay(context: context).then((value) {
                Navigator.pushNamed(context, CheckoutOrderView.routeName);
              });
            },
          ),
        );
      },
    );
  }
}

Future<void> _pay({required BuildContext context}) async {
  await PaymobManagerCubit.get(context)
      .getPaymentKey(
    amountCents: 10,
    currency: 'EGP',
    firstName: 'Akram',
    lastName: 'Mousa',
    email: 'akrammousa458@gmail.com',
    phoneNumber: '01097066403',
  )
      .then(
    (String paymentKey) {
      // var controller = WebViewController()
      //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //   ..setBackgroundColor(const Color(0x00000000))
      //   ..setNavigationDelegate(
      //     NavigationDelegate(
      //       onWebResourceError: (WebResourceError error) {},
      //       onNavigationRequest: (NavigationRequest request) {
      //         if (request.url.startsWith('https://www.youtube.com/')) {
      //           return NavigationDecision.prevent;
      //         }
      //         return NavigationDecision.navigate;
      //       },
      //     ),
      //   )
      //   ..loadRequest(Uri.parse('https://flutter.dev'));
    },
  );
}
