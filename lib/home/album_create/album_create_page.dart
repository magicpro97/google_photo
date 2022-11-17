import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../generated/l10n.dart';
import '../dialogs.dart';
import '../photo_list/media_item_view.dart';
import 'album_create_page_bloc.dart';

class AlbumCreatePage extends StatefulWidget {
  const AlbumCreatePage({Key? key}) : super(key: key);

  @override
  State<AlbumCreatePage> createState() => _AlbumCreatePageState();
}

class _AlbumCreatePageState extends State<AlbumCreatePage> {
  late final _albumCreateBloc = context.read<AlbumCreatePageBloc>();
  final List<MediaItemView> _mediaItemViews = [];
  List<Media> _mediaList = [];
  final _titleController = TextEditingController();

  void _onAddButtonPressed() {
    showMediaPicker(
      context: context,
      selectedMediaList: _mediaList,
      onPicking: (selectedMedias) => _mediaList = selectedMedias,
    ).then((value) {
      if (value != null) {
        _albumCreateBloc.add(UploadMedia(_mediaList));
        _mediaList = [];
      }
    });
  }

  void _onBackPressed() {
    context.router.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: _onBackPressed,
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              ValueListenableBuilder(
                valueListenable: _titleController,
                builder: (_, value, __) {
                  return TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: S.current.title,
                      errorText: value.text.isEmpty ? S.current.required : null,
                    ),
                    style: Theme.of(context).textTheme.headline3,
                    maxLines: 2,
                  );
                },
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (_, index) => _mediaItemViews[index],
                  itemCount: _mediaItemViews.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: _titleController,
        builder: (BuildContext context, TextEditingValue value, Widget? child) {
          return FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: value.text.isNotEmpty ? _onAddButtonPressed : null,
            backgroundColor: value.text.isEmpty ? Colors.grey : null,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
