import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/home/album_list/album_item_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/l10n.dart';
import '../../google_photo/google_photo.dart';
import '../home_page_bloc.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({
    Key? key,
  }) : super(key: key);

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  late final _homePageBloc = context.read<HomePageBloc>();
  final List<AlbumItemView> _albumItemViews = [];
  final _refreshController = RefreshController(
    initialRefresh: true,
  );

  String? _nextPageToken;

  void _onRefresh() {
    _homePageBloc.add(const GetAlbums(loadType: LoadType.refresh));
  }

  void _onLoadMore() {
    if (_nextPageToken != null) {
      _homePageBloc.add(GetAlbums(
        nextPageToken: _nextPageToken,
        loadType: LoadType.loadMore,
      ));
    } else {
      _refreshController.loadNoData();
    }
  }

  void _homePageBlocListener(BuildContext context, HomePageState state) {
    if (state is HomePageAlbumsLoaded) {
      final albumItemViews = state.albumItemViews;
      if (state.loadType == LoadType.refresh) {
        if (state.hasError) {
          _refreshController.refreshFailed();
        } else {
          if (albumItemViews.isNotEmpty) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshToIdle();
          }
          _albumItemViews.clear();
          _nextPageToken = state.nextPageToken;
        }
      } else {
        if (state.hasError) {
          _refreshController.loadFailed();
        } else {
          if (albumItemViews.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
          _nextPageToken = state.nextPageToken;
        }
      }
      _albumItemViews.addAll(state.albumItemViews);
    }
  }

  void _onAddButtonPressed() {}

  void _onAlbumItemPressed(Album album) {
    //context.pushRoute(AlbumRoute());
  }

  @override
  void initState() {
    super.initState();
    _homePageBloc.setOnAlbumItemPressed(_onAlbumItemPressed);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.album),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoadMore,
          enablePullUp: true,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (_, index) => _albumItemViews[index],
            itemCount: _albumItemViews.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: _onAddButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
