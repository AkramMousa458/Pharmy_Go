import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/providers.dart';
import 'package:pharmygo/core/utils/routes.dart';
import 'package:pharmygo/firebase_options.dart';
import 'package:pharmygo/public/cubits/switch_cubit/switch_cubit.dart';
import 'package:pharmygo/public/views/start_view.dart';

void main() async {
  // runApp(DevicePreview(builder: (context) => const PharmyGo()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PharmyGo());
}

class PharmyGo extends StatelessWidget {
  const PharmyGo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: providers,
            child: Builder(
              builder: (context) {
                return BlocBuilder<SwitchCubit, SwitchState>(
                  builder: (context, state) {
                    final switchCubit = context.read<SwitchCubit>();
                    return MaterialApp(
                      theme: switchCubit.themeData,
                      debugShowCheckedModeBanner: false,
                      routes: routes,
                      initialRoute: StartView.routeName,
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
