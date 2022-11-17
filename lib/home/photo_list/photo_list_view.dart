import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/app/router/app_router.dart';
import 'package:google_photo/shared/error.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../generated/l10n.dart';
import '../../google_photo/google_photo.dart';
import '../dialogs.dart';
import 'media_item_view.dart';
import 'photo_list_bloc.dart';

class PhotoListView extends StatefulWidget {
  const PhotoListView({
    Key? key,
    @pathParam this.id,
  }) : super(key: key);

  final String? id;

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  late final _photoListBloc = context.read<PhotoListBloc>();
  final List<MediaItemView> _mediaItemViews = [];
  final List<MediaItem> _mediaItems = [];
  final _refreshController = RefreshController(
    initialRefresh: true,
  );

  List<Media> _mediaList = [];
  var _progress = 0.0;
  String? _nextPageToken;

  void _onRefresh() {
    _photoListBloc.add(const GetMediaItems(loadType: LoadType.refresh));
  }

  void _onLoadMore() {
    if (_nextPageToken != null) {
      _photoListBloc.add(GetMediaItems(
        nextPageToken: _nextPageToken,
        loadType: LoadType.loadMore,
      ));
    } else {
      _refreshController.loadNoData();
    }
  }

  void _homePageBlocListener(BuildContext context, PhotoListState state) {
    if (state is UploadProgress) {
      _progress = state.current / state.total;
      if (_progress == 1) {
        _mediaList.clear();
      }
    } else if (state is PhotoListMediaItemLoaded) {
      final mediaItemViews = state.mediaItemViews;
      if (state.loadType == LoadType.refresh) {
        if (state.hasError) {
          _refreshController.refreshFailed();
        } else {
          if (mediaItemViews.isNotEmpty) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshToIdle();
          }
          _mediaItemViews.clear();
          _nextPageToken = state.nextPageToken;
        }
      } else {
        if (state.hasError) {
          _refreshController.loadFailed();
        } else {
          if (mediaItemViews.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
          _nextPageToken = state.nextPageToken;
        }
      }
      _mediaItemViews.addAll(state.mediaItemViews);
      _mediaItems.addAll(state.mediaItems);
    } else if (state is MediaItemCreated) {
      _refreshController.requestRefresh();
    } else if (state is PhotoListError) {
      showError(context, state.error);
    }
  }

  void _onAddButtonPressed() {
    showMediaPicker(
      context: context,
      selectedMediaList: _mediaList,
      onPicking: (selectedMedias) => _mediaList = selectedMedias,
    ).then((value) {
      if (value != null) {
        _photoListBloc.add(UploadMedia(_mediaList));
        _mediaList = [];
      }
    });
  }

  void _onMediaItemPressed(MediaItem mediaItem) {
    context.pushRoute(PhotoDetailRoute(
      mediaItems: _mediaItems,
      initialIndex: _mediaItems.indexOf(mediaItem),
    ));
  }

  @override
  void initState() {
    super.initState();
    _photoListBloc.setOnMediaItemPressed(_onMediaItemPressed);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoListBloc, PhotoListState>(
      listener: _homePageBlocListener,
      builder: _homePageBlocBuilder,
    );
  }

  Widget _homePageBlocBuilder(
    BuildContext context,
    PhotoListState state,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.photo),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Visibility(
              visible: _progress > 0 && _progress < 1,
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoadMore,
                enablePullUp: true,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (_, index) => _mediaItemViews[index],
                  itemCount: _mediaItemViews.length,
                ),
              ),
            ),
          ],
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
