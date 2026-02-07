import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/ui/resources/asset_manger.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.colorPrimary,
      child: SafeArea(
        child: Builder(
          builder: (ctx) {
            final tabsRouter = AutoTabsRouter.of(ctx);
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                _UserTile(),
                SizedBox(height: AppSize.s16),
                _SectionTitle(title: 'Menu'),
                _DrawerItem(
                  iconPath: IconsAssets.homeIcon,
                  label: 'Home',
                  index: 0,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 0),
                ),
                _DrawerItem(
                  iconPath: IconsAssets.liveStreamIcon,
                  label: 'Live Tv',
                  index: 1,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 1),
                ),
                _DrawerItem(
                  iconPath: IconsAssets.videoIcon,
                  label: 'Movies',
                  index: 2,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 2),
                ),
                _DrawerItem(
                  iconPath: IconsAssets.reelsIcon,
                  label: 'Series',
                  index: 2,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 2),
                ),
                SizedBox(height: AppSize.s16),
                _SectionTitle(title: 'General'),
                _DrawerItem(
                  iconPath: IconsAssets.favouriteIcon,
                  label: 'Favourite',
                  index: 3,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 3),
                ),
                _DrawerItem(
                  iconPath: IconsAssets.settingsIcon,
                  label: 'Settings',
                  index: 4,
                  tabsRouter: tabsRouter,
                  onTap: () => _onItemTap(ctx, tabsRouter, 4),
                ),
                _DrawerItem(
                  iconPath: IconsAssets.logoutIcon,
                  label: 'Log Out',
                  index: -1,
                  tabsRouter: tabsRouter,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    // TODO: trigger logout
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onItemTap(BuildContext context, TabsRouter? tabsRouter, int index) {
    Navigator.of(context).pop();
    if (tabsRouter != null && index >= 0 && index < 5) {
      tabsRouter.setActiveIndex(index);
    }
  }
}

class _UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSize.s16),
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16, vertical: AppSize.s12),
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
                colorFilter: ColorFilter.mode(
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ColorManager.colorWhite,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s20, vertical: AppSize.s8),
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

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.iconPath,
    required this.label,
    required this.index,
    required this.tabsRouter,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final int index;
  final TabsRouter? tabsRouter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index >= 0 &&
        tabsRouter != null &&
        tabsRouter!.activeIndex == index;
    final color = isSelected ? ColorManager.colorThird : ColorManager.colorWhite;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
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
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
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
