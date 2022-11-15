import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/shared/error.dart';

import '../app/di/dependencies.dart';
import '../generated/l10n.dart';
import '../shared/widgets/full_screen_loading_page.dart';
import 'home_page_bloc.dart';
import 'photo_list_view.dart';

class HomePage extends StatefulWidget with AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (_) => getIt(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  void _homePageBlocListener(
    BuildContext context,
    HomePageState state,
  ) {
    if (state is HomePageError) {
      showError(context, state.error);
    }
  }

  void _onNavigationItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: _homePageBlocListener,
      builder: _homePageBlocBuilder,
    );
  }

  Widget _homePageBlocBuilder(
    BuildContext context,
    HomePageState state,
  ) {
    return FullScreenLoadingPage(
      isLoading: state is HomePageLoading ? state.isLoading : false,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const PhotoListView(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onNavigationItemTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.photo),
            label: S.current.photo,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.album),
            label: S.current.album,
          ),
        ],
      ),
    );
  }
}
