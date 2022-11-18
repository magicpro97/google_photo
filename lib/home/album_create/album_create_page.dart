import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/home/album_create/media_item/album_media_item_view_bloc.dart';
import 'package:google_photo/shared/error.dart';
import 'package:google_photo/shared/widgets/full_screen_loading_page.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../app/di/dependencies.dart';
import '../../generated/l10n.dart';
import '../dialogs.dart';
import 'album_create_page_bloc.dart';

class AlbumCreatePage extends StatefulWidget with AutoRouteWrapper {
  const AlbumCreatePage({Key? key}) : super(key: key);

  @override
  State<AlbumCreatePage> createState() => _AlbumCreatePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AlbumCreatePageBloc>(
      create: (_) => getIt(),
      child: this,
    );
  }
}

class _AlbumCreatePageState extends State<AlbumCreatePage> {
  late final _albumCreateBloc = context.read<AlbumCreatePageBloc>();
  final List<BlocProvider<AlbumMediaItemViewBloc>> _mediaItemViews = [];
  List<Media> _mediaList = [];
  String? _albumId;
  final _titleController = TextEditingController();
  final _titleFocus = FocusNode();

  void _onAddButtonPressed() {
    showMediaPicker(
      context: context,
      selectedMediaList: _mediaList,
      onPicking: (selectedMedias) => _mediaList = selectedMedias,
    ).then((value) {
      if (value != null) {
        _albumCreateBloc.add(UploadMedia(
          mediaList: _mediaList,
        ));
        _mediaList = [];
      }
    });
  }

  void _onBackPressed() {
    context.router.pop(_albumId != null);
  }

  void _albumCreatePageBlocListener(
    BuildContext context,
    AlbumCreatePageState state,
  ) {
    if (state is UploadingMedia) {
      _mediaItemViews.addAll(state.albumMediaItemViews
          .map((e) => BlocProvider<AlbumMediaItemViewBloc>(
                create: (_) => getIt(),
                child: e,
              ))
          .toList(growable: false));
    } else if (state is AlbumCreated) {
      _albumId = state.albumId;
    } else if (state is AlbumCreateError) {
      showError(context, state.error);
    }
  }

  void _onMediaItemPressed(Media media) {}

  void _onMediaItemUploaded(Media media, String uploadToken) {
    _albumCreateBloc.add(CreateMediaItem(
      uploadToken: uploadToken,
      albumId: _albumId!,
    ));
  }

  @override
  void initState() {
    super.initState();
    _albumCreateBloc.setOnMediaItemPressed(_onMediaItemPressed);
    _albumCreateBloc.setOnMediaItemUploaded(_onMediaItemUploaded);

    _titleFocus.addListener(() {
      if (!_titleFocus.hasFocus && _titleController.text.isNotEmpty) {
        if (_albumId == null) {
          _albumCreateBloc.add(CreateAlbum(_titleController.text));
        } else {
          _albumCreateBloc.add(UpdateAlbum(
            albumId: _albumId!,
            albumTitle: _titleController.text,
          ));
        }
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumCreatePageBloc, AlbumCreatePageState>(
      listener: _albumCreatePageBlocListener,
      builder: _albumCreatePageBlocBuilder,
    );
  }

  Widget _albumCreatePageBlocBuilder(
    BuildContext context,
    AlbumCreatePageState state,
  ) {
    return FullScreenLoadingPage(
      isLoading: state is AlbumCreateLoading ? state.isLoading : false,
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
                    focusNode: _titleFocus,
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
      floatingActionButton: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: _albumId != null ? _onAddButtonPressed : null,
        backgroundColor: _albumId == null ? Colors.grey : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}
