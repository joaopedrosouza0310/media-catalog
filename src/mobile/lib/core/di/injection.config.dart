// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media_catalog_app/app/locale_cubit.dart' as _i955;
import 'package:media_catalog_app/core/di/register_module.dart' as _i152;
import 'package:media_catalog_app/core/network/api_client.dart' as _i711;
import 'package:media_catalog_app/core/theme/theme_cubit.dart' as _i363;
import 'package:media_catalog_app/features/catalog/data/datasources/catalog_remote_data_source.dart'
    as _i599;
import 'package:media_catalog_app/features/catalog/data/datasources/favorites_local_data_source.dart'
    as _i953;
import 'package:media_catalog_app/features/catalog/data/repositories/catalog_repository_impl.dart'
    as _i734;
import 'package:media_catalog_app/features/catalog/domain/repositories/catalog_repository.dart'
    as _i208;
import 'package:media_catalog_app/features/catalog/domain/usecases/get_catalog.dart'
    as _i62;
import 'package:media_catalog_app/features/catalog/domain/usecases/get_favorite_ids.dart'
    as _i638;
import 'package:media_catalog_app/features/catalog/domain/usecases/toggle_favorite.dart'
    as _i990;
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart'
    as _i497;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i711.ApiClient>(() => _i711.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i953.FavoritesLocalDataSource>(
      () => _i953.SharedPreferencesFavoritesLocalDataSource(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i955.LocaleCubit>(
      () => _i955.LocaleCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i363.ThemeCubit>(
      () => _i363.ThemeCubit(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i599.CatalogRemoteDataSource>(
      () => _i599.DioCatalogRemoteDataSource(gh<_i711.ApiClient>()),
    );
    gh.lazySingleton<_i208.CatalogRepository>(
      () => _i734.CatalogRepositoryImpl(
        gh<_i599.CatalogRemoteDataSource>(),
        gh<_i953.FavoritesLocalDataSource>(),
      ),
    );
    gh.factory<_i62.GetCatalog>(
      () => _i62.GetCatalog(gh<_i208.CatalogRepository>()),
    );
    gh.factory<_i638.GetFavoriteIds>(
      () => _i638.GetFavoriteIds(gh<_i208.CatalogRepository>()),
    );
    gh.factory<_i990.ToggleFavorite>(
      () => _i990.ToggleFavorite(gh<_i208.CatalogRepository>()),
    );
    gh.factory<_i497.CatalogCubit>(
      () => _i497.CatalogCubit(
        gh<_i62.GetCatalog>(),
        gh<_i638.GetFavoriteIds>(),
        gh<_i990.ToggleFavorite>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i152.RegisterModule {}
