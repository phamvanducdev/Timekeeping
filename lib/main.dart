import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timekeeping/configs/routes/routes.dart';
import 'package:timekeeping/configs/themes/themes.dart';
import 'package:timekeeping/core/configs.dart';
import 'package:timekeeping/core/constants/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:timekeeping/data/repositories/api_repository_impl.dart';
import 'package:timekeeping/data/sources/remote/api_service.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.initialize();
  await AppConfigs.initialize(AppConfigs.development());
  runApp(const TimekeepingApp());
}

class TimekeepingApp extends StatelessWidget {
  const TimekeepingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(
          create: (context) {
            final options = BaseOptions(
              baseUrl: AppConfigs.development().BASE_URL,
              sendTimeout: const Duration(seconds: 30),
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
            );
            return Dio(options)
              ..interceptors.add(
                LogInterceptor(
                  request: true,
                  responseBody: true,
                ),
              );
          },
        ),
        Provider<ApiService>(
          create: (context) => ApiService(
            context.read<Dio>(),
          ),
        ),
        Provider<ApiRepository>(
          create: (context) => ApiRepositoryImpl(
            context.read<ApiService>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Timekeeping App',
        theme: appTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
