import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/config/injection.dart';
import '../../../../core/ui/resources/asset_manger.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';
import '../../../../core/ui/routes/router.gr.dart';
import '../../../../core/ui/widgets/custom_app_bar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/root_cubit.dart';

const double _kWebBreakpoint = 900;

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  static final navItems = <NavItem>[
    NavItem(name: 'home', icon: IconsAssets.homeIcon),
    NavItem(name: 'live_tv', icon: IconsAssets.liveStreamIcon),
    NavItem(name: 'movies', icon: IconsAssets.videoIcon),
    NavItem(name: 'series', icon: IconsAssets.reelsIcon),
    NavItem(name: 'menu', icon: IconsAssets.menuIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<HomeCubit>()..getHomeData(),
          ),
          BlocProvider.value(
            value: locator<RootCubit>()..getUnreadNotificationCount(),
          ),
        ],
        child: BlocBuilder<RootCubit, RootState>(
          builder: (context, state) {
            final isWeb = MediaQuery.sizeOf(context).width >= _kWebBreakpoint;
            final scaffoldKey = state.scaffoldKey!;
            if (isWeb) {
              return _WebRootLayout(
                scaffoldKey: scaffoldKey,
                notificationState: state,
              );
            }
            return AutoTabsScaffold(
              routes: const [
                HomeRoute(),
                LiveRoute(),
                MoviesRoute(),
                SeriesRoute(),
                SettingsRoute(),
              ],
              appBarBuilder: (ctx, tabsRouter) {
                if (tabsRouter.activeIndex == 0) {
                  return CustomAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Jhon Doe',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: ColorManager.colorFontPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          'Discover The World',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: ColorManager.colorFontSecondary,
                              ),
                        ),
                      ],
                    ),
                    onNotificationPressed: () {
                      // ctx.router.push(const NotificationsRoute());
                    },
                    onSearchPressed: () {
                      // TODO: Navigate to search or open search
                    },
                  );
                }
                return null;
              },
              bottomNavigationBuilder: (ctx, tabsRouter) => _MobileNavBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MobileNavBar extends StatelessWidget {
  const _MobileNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const double _indicatorHeight = 3;
  static final double _iconSize = AppSize.s22;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sHeight * 0.08,
      decoration: const BoxDecoration(color: ColorManager.colorSecondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(RootPage.navItems.length, (index) {
          final navItem = RootPage.navItems[index];
          final isSelected = currentIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _indicatorHeight + AppSize.s4,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isSelected ? AppSize.sWidth * 0.11 : 0,
                        height: _indicatorHeight,
                        decoration: BoxDecoration(
                          color: ColorManager.colorThird,
                          borderRadius: BorderRadius.circular(
                            _indicatorHeight / 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s6),
                  SvgPicture.asset(
                    navItem.icon,
                    width: _iconSize,
                    height: _iconSize,
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? ColorManager.colorThird
                          : ColorManager.colorGrey2,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (isSelected) ...[
                    SizedBox(height: AppSize.s4),
                    Text(
                      navItem.name.tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: ColorManager.colorThird,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _WebRootLayout extends StatelessWidget {
  const _WebRootLayout({
    required this.scaffoldKey,
    required this.notificationState,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final RootState notificationState;

  static const double _sidebarWidth = 260;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        LiveRoute(),
        MoviesRoute(),
        SeriesRoute(),
        SettingsRoute(),
      ],
      builder: (BuildContext context, Widget child) {
        final tabsRouter = context.tabsRouter;
        return Row(
          children: [
            _WebSideBar(width: _sidebarWidth, tabsRouter: tabsRouter),
            Expanded(
              child: Container(
                color: const Color(0xFF0D1B2A),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      title: Text(
                        RootPage.navItems[tabsRouter.activeIndex].name.tr(),
                      ),
                      showBackButton: false,
                      onNotificationPressed: () {},
                    ),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WebSideBar extends StatelessWidget {
  const _WebSideBar({required this.width, required this.tabsRouter});

  final double width;
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ColorManager.colorPrimary,
        border: Border(
          right: BorderSide(
            color: ColorManager.colorThird.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _UserSection(),
            SizedBox(height: AppSize.s16),
            _NavSectionTitle(title: 'menu'.tr()),
            ...List.generate(5, (i) => i).map(
              (i) => _SideNavItem(
                iconPath: [
                  IconsAssets.homeIcon,
                  IconsAssets.liveStreamIcon,
                  IconsAssets.videoIcon,
                  IconsAssets.reelsIcon,
                  IconsAssets.menuIcon,
                ][i],
                label: ['home', 'live_tv', 'movies', 'series', 'menu'][i].tr(),
                index: i,
                tabsRouter: tabsRouter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSize.s16),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s16,
        vertical: AppSize.s12,
      ),
      decoration: BoxDecoration(
        color: ColorManager.colorPrimary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                IconsAssets.notificationIcon,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  ColorManager.colorWhite,
                  BlendMode.srcIn,
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ColorManager.colorThird,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: AppSize.s12),
          Expanded(
            child: Text(
              'Jhon Doe',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: ColorManager.colorWhite),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavSectionTitle extends StatelessWidget {
  const _NavSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s20,
        vertical: AppSize.s8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: ColorManager.colorWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  const _SideNavItem({
    required this.iconPath,
    required this.label,
    required this.index,
    required this.tabsRouter,
  });

  final String iconPath;
  final String label;
  final int index;
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final isSelected = tabsRouter.activeIndex == index;
    final color = isSelected
        ? ColorManager.colorThird
        : ColorManager.colorGrey2;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => tabsRouter.setActiveIndex(index),
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.s12,
              vertical: AppSize.s12,
            ),
            decoration: BoxDecoration(
              border: isSelected
                  ? const Border(
                      left: BorderSide(
                        color: ColorManager.colorThird,
                        width: 3,
                      ),
                    )
                  : null,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
                SizedBox(width: AppSize.s12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final String name;
  final String icon;

  const NavItem({required this.name, required this.icon});
}
