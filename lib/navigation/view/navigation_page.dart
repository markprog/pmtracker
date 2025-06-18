import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix_app_w_bloc/tasks/bloc/tasks_bloc.dart';
import 'package:shared_preferences_repository/storage_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import '../../home/view/home_page.dart';
import '../../tasks/view/tasks_page.dart';
import '../cubit/home_nav_bar_cubit.dart';
import '../nav_bar/nav_bar.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => NavigationPage());
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final repository = context.read<TasksRepository>();
    final storage = context.read<SharedPreferencesHelper>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeNavBarCubit(),),
        BlocProvider(create: (context) => TasksBloc(repository, storage)),
      ],

      child: BlocBuilder<HomeNavBarCubit, HomeNavBarState>(
          builder: (context, state) {
        final bloc = context.read<HomeNavBarCubit>();

        // Синхронизируем PageView с состоянием навбара
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentIndex) {
          _pageController.jumpToPage(state.currentIndex);
        }
        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              bloc.changeTo(index);
            },
            children: [
              HomePage(),
              TasksPage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: NavBar(
            onTap: (index) {
              bloc.changeTo(index);
              _pageController.animateToPage(index,
                  duration: const Duration(microseconds: 250),
                  curve: Curves.ease);
            },
          ),
        );
      }),
    );
  }
}
