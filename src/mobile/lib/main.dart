import 'package:flutter/widgets.dart';
import 'package:media_catalog_app/app/app.dart';
import 'package:media_catalog_app/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MediaCatalogApp());
}
