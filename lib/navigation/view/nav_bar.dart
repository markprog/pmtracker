import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_bloc_app/navigation/cubit/home_nav_bar_cubit.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
        builder: (context, state) {
      var bloc = context.read<HomeNavBarCubit>();

      return BottomNavigationBar(
          onTap: (index) => bloc.changeTo(index),
          currentIndex: state.currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Account"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_circle), label: "Account")
          ]);
    });
  }
}
