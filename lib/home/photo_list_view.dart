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

  void _onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return MediaPicker(
          mediaList: _mediaList,
          onPick: (selectedList) {
            setState(() => _mediaList = selectedList);
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
          mediaCount: MediaCount.multiple,
          mediaType: MediaType.image,
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
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageMediaItemLoaded) {
          _mediaItemViews.addAll(state.mediaItemViews);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(S.current.photo),
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (_, index) => _mediaItemViews[index],
            itemCount: _mediaItemViews.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _onAddButtonPressed,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
