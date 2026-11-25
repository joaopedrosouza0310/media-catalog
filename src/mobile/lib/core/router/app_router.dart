import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media_catalog_app/core/di/injection.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/pages/catalog_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CatalogCubit>()..load(),
        child: const CatalogPage(),
      ),
    ),
  ],
);
