import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_catalog_app/features/catalog/domain/entities/media_item.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:media_catalog_app/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:media_catalog_app/features/catalog/presentation/widgets/media_detail_sheet.dart';

abstract final class MediaDetails {
  static Future<void> show(BuildContext context, MediaItem item) {
    final catalogCubit = context.read<CatalogCubit>();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      useSafeArea: true,
      builder: (sheetContext) => BlocProvider.value(
        value: catalogCubit,
        child: BlocBuilder<CatalogCubit, CatalogState>(
          builder: (context, state) => MediaDetailSheet(
            item: item,
            isFavorite: state.favoriteIds.contains(item.id),
            onFavorite: () =>
                context.read<CatalogCubit>().toggleFavorite(item.id),
          ),
        ),
      ),
    );
  }
}
