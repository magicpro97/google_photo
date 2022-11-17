import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_photo/google_photo/google_photo.dart';
import 'package:google_photo/shared/extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../generated/l10n.dart';
import '../google_photo/google_photo_repository.dart';
import '../shared/error.dart';
import 'album_item_view/album_item_view.dart';
import 'media_item_factory.dart';
import 'media_item_view/media_item_view.dart';
import 'upload_status.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GooglePhotoRepository _googlePhotoRepository;
  final MediaItemFactory _mediaItemFactory;

  late final StreamSubscription<UploadTaskResponse> _uploadSubscription;

  final _taskIdSet = <String, UploadStatus>{};

  late void Function(MediaItem) onMediaItemPressed;
  late void Function(Album) onAlbumItemPressed;

  HomePageBloc(
    this._googlePhotoRepository,
    this._mediaItemFactory,
  ) : super(const HomePageLoading()) {
    on<GetMediaItems>(_onGetMediaItems);
    on<GetAlbums>(_onGetAlbums);
    on<UploadMedia>(_onUploadMedia);
    on<UpdateUploadStatus>(_onUpdateUploadStatus);
    on<CreateMediaItem>(_onCreateMediaItem);

    _uploadSubscription =
        _googlePhotoRepository.uploadMediaItemResponse$.listen((event) {
      if (_taskIdSet[event.taskId] == UploadStatus.loading) {
        final statusCode = event.statusCode;
        if (statusCode != null && statusCode >= 200 && statusCode < 400) {
          _taskIdSet[event.taskId] = UploadStatus.done;
          add(CreateMediaItem(event.response!));
        } else {
          _taskIdSet[event.taskId] = UploadStatus.error;
        }
      }
    });
  }

  int get _current => _taskIdSet.entries.fold(
      0,
      (previousValue, element) => element.value != UploadStatus.loading
          ? previousValue++
          : previousValue);

  void setOnMediaItemPressed(void Function(MediaItem) onMediaItemPressed) {
    this.onMediaItemPressed = onMediaItemPressed;
  }

  void setOnAlbumPressed(void Function(Album) onAlbumItemPressed) {
    this.onAlbumItemPressed = onAlbumItemPressed;
  }

  @override
  Future<void> close() async {
    super.close();
    _uploadSubscription.cancel();
  }

  FutureOr<void> _onGetMediaItems(
    GetMediaItems event,
    Emitter<HomePageState> emit,
  ) async {
    final loadType = event.loadType;
    emit(HomePageLoading(isLoading: true, loadType: loadType));

    try {
      final response = await _googlePhotoRepository.getMediaItems(
        pageToken: event.nextPageToken,
      );

      emit(HomePageMediaItemLoaded(
        mediaItemViews: await _mediaItemFactory.generateMediaItemViews(
          response.mediaItems ?? [],
          onMediaItemPressed,
        ),
        loadType: loadType,
        nextPageToken: response.nextPageToken,
      ));
    } catch (e) {
      _onError(e, emit);
      emit(HomePageMediaItemLoaded(
        loadType: loadType,
        hasError: true,
      ));
    } finally {
      emit(HomePageLoading(isLoading: false, loadType: loadType));
    }
  }

  FutureOr<void> _onUploadMedia(
    UploadMedia event,
    Emitter<HomePageState> emit,
  ) async {
    final mediaList = event.mediaList;

    final tasks = mediaList
        .where((e) => e.file != null)
        .where((e) => e.file!.path.fileName.mineType != null)
        .map((e) => _googlePhotoRepository.uploadMediaItems(
              mimeType: e.file!.path.fileName.mineType!,
              filePath: e.file!.path,
            ))
        .toList(growable: false);

    final taskIdList = await Future.wait(tasks);
    _taskIdSet.addAll(taskIdList.fold({}, (previousValue, element) {
      previousValue[element] = UploadStatus.loading;
      return previousValue;
    }));

    add(UpdateUploadStatus(current: 0, total: _taskIdSet.length));
  }

  FutureOr<void> _onUpdateUploadStatus(
    UpdateUploadStatus event,
    Emitter<HomePageState> emit,
  ) {
    emit(UploadProgress(current: event.current, total: event.total));
  }

  FutureOr<void> _onCreateMediaItem(
    CreateMediaItem event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      await _googlePhotoRepository.createMediaItems([
        NewMediaItem(
          description: '',
          simpleMediaItem: SimpleMediaItem(
            uploadToken: event.uploadToken,
          ),
        )
      ]);

      add(UpdateUploadStatus(
        current: _current,
        total: _taskIdSet.length,
      ));

      add(const GetMediaItems());
    } catch (e) {
      _onError(e, emit);
    }
  }

  void _onError(Object e, Emitter<HomePageState> emit) {
    if (e is DioError && e.response?.statusCode == 401) {
      emit(HomePageError(UnauthorizedError('')));
    } else {
      emit(HomePageError(AppError(S.current.something_happened)));
    }
  }

  FutureOr<void> _onGetAlbums(
    GetAlbums event,
    Emitter<HomePageState> emit,
  ) async {
    final loadType = event.loadType;
    emit(HomePageLoading(isLoading: true, loadType: loadType));

    try {
      final response = await _googlePhotoRepository.getAlbums(
        pageToken: event.nextPageToken,
      );

      emit(HomePageAlbumsLoaded(
        albumItemViews: await _mediaItemFactory.generateAlbumViews(
          response.albums ?? [],
          onAlbumItemPressed,
        ),
        loadType: loadType,
        nextPageToken: response.nextPageToken,
      ));
    } catch (e) {
      _onError(e, emit);
      emit(HomePageAlbumsLoaded(
        loadType: loadType,
        hasError: true,
      ));
    } finally {
      emit(HomePageLoading(isLoading: false, loadType: loadType));
    }
  }
}
