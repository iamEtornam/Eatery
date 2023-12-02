import 'package:eatery/config/dev_config.dart';
import 'package:eatery/config/prod_config.dart';
import 'package:flutter/foundation.dart';

class Config {
  static const String supabaseUrl =
      kDebugMode ? DevConfig.supabaseUrl : ProdConfig.supabaseUrl;
  static const String supabaseKey =
      kDebugMode ? DevConfig.supabaseKey : ProdConfig.supabaseKey;
}
