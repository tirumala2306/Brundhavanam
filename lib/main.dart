import 'package:brundhavanam/core/navigations/app_router.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:brundhavanam/features/registration/bloc/auth_bloc.dart';
import 'package:brundhavanam/features/registration/repository/auth_repository.dart';
import 'package:brundhavanam/services/api_services/api_client.dart';
import 'package:brundhavanam/services/api_services/crud_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final apiClient = ApiClient();
  final appService = AppService(apiClient);
  final authRepository = AuthRepository(appService);

  runApp(
    BlocProvider(create: (_) => AuthBloc(authRepository), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: AppRouter.router,

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),

          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
