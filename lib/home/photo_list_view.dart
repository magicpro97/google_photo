import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../generated/l10n.dart';
import 'home_page_bloc.dart';
import 'media_item_view/media_item_view.dart';

class PhotoListView extends StatefulWidget {
  const PhotoListView({
    Key? key,
  }) : super(key: key);

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  late final _homePageBloc = context.read<HomePageBloc>();
  final List<MediaItemView> _mediaItemViews = [];

  List<Media> _mediaList = [];
  var _progress = 0.0;

  void _homePageBlocListener(BuildContext context, HomePageState state) {
    if (state is UploadProgress) {
      _progress = state.current / state.total;
      if (_progress == 1) {
        _mediaList.clear();
      }
    } else if (state is HomePageMediaItemLoaded) {
      _mediaItemViews.addAll(state.mediaItemViews);
    }
  }

  void _onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MediaPicker(
          mediaList: _mediaList,
          onPick: (selectedList) {
            _mediaList = selectedList;
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
          mediaCount: MediaCount.multiple,
          mediaType: MediaType.all,
          decoration: PickerDecoration(
            actionBarPosition: ActionBarPosition.top,
            blurStrength: 2,
            completeText: S.current.next,
          ),
        );
      },
    ).whenComplete(() => _homePageBloc.add(UploadMedia(_mediaList)));
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
        title: Text(S.current.photo),
      ),
      body: Column(
        children: [
          Visibility(
            visible: _progress > 0 && _progress < 1,
            child: LinearProgressIndicator(
              value: _progress,
            ),
          ),
          Expanded(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
