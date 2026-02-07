import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/ui/resources/asset_manger.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/font_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';
import '../../../../core/ui/widgets/custom_cached_image.dart';
import '../../models/movie_model.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({
    super.key,
    required this.movie,
    this.width,
    this.height,
    this.isHorizontalListItem = false,
    this.onTap,
    this.onFavouriteTap,
  });

  final MovieModel movie;
  final double? width;
  final double? height;
  final bool isHorizontalListItem;
  final VoidCallback? onTap;
  final VoidCallback? onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = width ??
              (constraints.maxWidth.isFinite ? constraints.maxWidth : null);
          final availableHeight = constraints.maxHeight.isFinite &&
                  constraints.maxHeight > 0
              ? constraints.maxHeight
              : AppSize.sHeight * 0.2;
          final cardHeight = height ?? availableHeight;
          final cardWidth = availableWidth;

          return Container(
            width: cardWidth,
            height: cardHeight,
            margin: isHorizontalListItem
                ? EdgeInsets.symmetric(vertical: AppSize.s6)
                : EdgeInsets.symmetric(
                    horizontal: AppSize.s16,
                    vertical: AppSize.s6,
                  ),
            decoration: BoxDecoration(
              color: ColorManager.colorPrimary,
              borderRadius: BorderRadius.circular(AppSize.s12),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.colorBlack.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSize.s8),
                  child: _PosterSection(
                    posterUrl: movie.posterUrl,
                    height: cardHeight - AppSize.s16,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.s8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (movie.certification.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.s8,
                                  vertical: AppSize.s4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s6),
                                  border: Border.all(
                                    color: ColorManager.colorWhite
                                        .withValues(alpha: 0.8),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  movie.certification,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: ColorManager.colorFontPrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: FontSize.s10,
                                      ),
                                ),
                              ),
                            const Spacer(),
                            GestureDetector(
                              onTap: onFavouriteTap,
                              child: SvgPicture.asset(
                                IconsAssets.favouriteIcon,
                                width: AppSize.s30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.s8),
                        Expanded(
                          child: Text(
                            movie.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: ColorManager.colorFontPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.s16,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (movie.genres.isNotEmpty) ...[
                          SizedBox(height: AppSize.s4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                IconsAssets.videoIcon,
                                width: AppSize.s20,
                                height: AppSize.s20,
                                colorFilter: const ColorFilter.mode(
                                  ColorManager.colorFontPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: AppSize.s6),
                              Expanded(
                                child: Text(
                                  movie.genresDisplay,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: ColorManager.colorFontPrimary
                                            .withValues(alpha: 0.9),
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(
                              IconsAssets.starIcon,
                              width: AppSize.s24,
                            ),
                            SizedBox(width: AppSize.s4),
                            Text(
                              movie.rating,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: ColorManager.colorFontPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: FontSize.s14,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PosterSection extends StatelessWidget {
  const _PosterSection({required this.posterUrl, double? height})
    : _height = height;

  final String posterUrl;
  final double? _height;

  @override
  Widget build(BuildContext context) {
    final refHeight = _height ?? AppSize.sHeight * 0.2;
    final posterWidth = refHeight * 0.75;
    return Container(
      width: posterWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(
          color: ColorManager.colorWhite.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomCachedNetworkImage(
        imageUrl: posterUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        borderRadius: 0,
      ),
    );
  }
}
