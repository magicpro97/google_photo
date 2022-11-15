import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../generated/l10n.dart';
import 'home_page_bloc.dart';
import 'media_item_view.dart';

class PhotoListView extends StatefulWidget {
  const PhotoListView({
    Key? key,
  }) : super(key: key);

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  final List<MediaItemView> _mediaItemViews = [];

  void _onAddButtonPressed() {}

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
