import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/AppColors.dart';
import '../../constants/AppIcons.dart';
import '../cubit/home_nav_bar_cubit.dart';

class NavBar extends StatelessWidget {
  final ValueChanged<int>? onTap;

  const NavBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
        builder: (context, state) {
      var bloc = context.read<HomeNavBarCubit>();

      return BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.dark,
          selectedItemColor: AppColor.white,
          unselectedItemColor: AppColor.white,
          unselectedLabelStyle:
              const TextStyle(fontSize: 10, color: AppColor.white),
          selectedLabelStyle:
              const TextStyle(fontSize: 10, color: AppColor.white),
          onTap: onTap ?? (index) => bloc.changeTo(index),
          currentIndex: state.currentIndex,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: SvgPicture.asset(height: 35, AppIcons.homeInactive),
              activeIcon: SvgPicture.asset(height: 35, AppIcons.homeActive),
            ),
            BottomNavigationBarItem(
              label: "Tasks",
              // label: AppLocalizations.of(context)?.navigationTasks,
              icon: SvgPicture.asset(height: 35, AppIcons.taskInactive),
              activeIcon: SvgPicture.asset(height: 35, AppIcons.taskActive),
            ),
            BottomNavigationBarItem(
              label: "Account",
            icon: SvgPicture.asset(AppIcons.accActive, height: 35),
          activeIcon: SvgPicture.asset(height: 35, AppIcons.accInactive),
            )
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_circle), label: "Account")
          ]);
    });
  }
}
