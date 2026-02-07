import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/resources/breakpoints.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';
import '../../models/movie_model.dart';
import 'movie_card_widget.dart';

class TopMoviesSectionWidget extends StatelessWidget {
  const TopMoviesSectionWidget({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.onFavouriteTap,
  });

  final List<MovieModel> movies;
  final void Function(MovieModel movie)? onMovieTap;
  final void Function(MovieModel movie)? onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    final isLarge = context.isLargeScreen;
    // Mobile: ~1.3 cards visible; large / TV: fixed width so multiple cards, 16:9-friendly row height
    final cardWidth = isLarge
        ? (context.screenWidth * 0.18).clamp(200.0, 320.0)
        : context.screenWidth * 0.75;
    final cardHeight = isLarge
        ? (cardWidth / (16 / 9)).clamp(100.0, 180.0) // poster-ish ratio for row
        : AppSize.sHeight * 0.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            isLarge ? 24 : AppSize.s16,
            AppSize.s20,
            isLarge ? 24 : AppSize.s16,
            AppSize.s12,
          ),
          child: Text(
            'top_movies'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorManager.colorFontPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: cardHeight + AppSize.s12,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: isLarge ? 24 : AppSize.s16),
            itemCount: movies.length,
            separatorBuilder: (_, __) => SizedBox(width: isLarge ? 16 : AppSize.s12),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SizedBox(
                width: cardWidth,
                child: MovieCardWidget(
                  movie: movie,
                  width: cardWidth,
                  height: cardHeight,
                  isHorizontalListItem: true,
                  onTap: onMovieTap != null ? () => onMovieTap!(movie) : null,
                  onFavouriteTap: onFavouriteTap != null
                      ? () => onFavouriteTap!(movie)
                      : null,
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppSize.s24),
      ],
    );
  }
}
