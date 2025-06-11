import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_bloc_app/home/home.dart';
import 'package:matrix_bloc_app/navigation/view/nav_bar.dart';
import 'package:matrix_bloc_app/notifications/view/notifications_page.dart';
import 'package:matrix_bloc_app/tasks/view/tasks_page.dart';

import '../cubit/home_nav_bar_cubit.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => NavigationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeNavBarCubit(),
      child: BlocBuilder<HomeNavBarCubit, HomeNavBarState>(builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              HomePage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: NavBar(),
        );
      }),
    );
  }
}