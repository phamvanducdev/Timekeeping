// ignore_for_file: non_constant_identifier_names

import 'package:timekeeping/core/constants/api_enpoints.dart';

class AppConfigs {
  static AppConfigs? _instance;

  static AppConfigs get instance => _instance!;

  static Future<void> initialize(AppConfigs appConfigs) async {
    _instance = appConfigs;
  }

  final String BASE_URL;
  AppConfigs({required this.BASE_URL});

  factory AppConfigs.development() => AppConfigs(BASE_URL: ApiEndpoint.DEVELOP_BASE_URL);
  factory AppConfigs.production() => AppConfigs(BASE_URL: ApiEndpoint.PRODUCTION_BASE_URL);
}
