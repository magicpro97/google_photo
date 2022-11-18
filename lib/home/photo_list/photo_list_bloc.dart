import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_photo/shared/extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../google_photo/google_photo.dart';
import '../../google_photo/google_photo_repository.dart';
import '../../shared/error.dart';
import '../media_item_factory.dart';
import '../upload_status.dart';
import 'media_item_view.dart';

part 'photo_list_event.dart';

part 'photo_list_state.dart';

@injectable
class PhotoListBloc extends Bloc<PhotoListEvent, PhotoListState> {
  final GooglePhotoRepository _googlePhotoRepository;
  final MediaItemFactory _mediaItemFactory;

  late final StreamSubscription<UploadTaskResponse> _uploadSubscription;

  final _taskIdSet = <String, UploadStatus>{};

  late void Function(MediaItem) onMediaItemPressed;

  PhotoListBloc(
    this._googlePhotoRepository,
    this._mediaItemFactory,
  ) : super(const PhotoListLoading()) {
    on<GetMediaItems>(_onGetMediaItems);
    on<UploadMedia>(_onUploadMedia);
    on<UpdateUploadStatus>(_onUpdateUploadStatus);
    on<CreateMediaItem>(_onCreateMediaItem);
    on<CreateMediaItems>(_onCreateMediaItems);

    // _uploadSubscription =
    //     _googlePhotoRepository.uploadMediaItemResponse$.listen((event) {
    //   if (_taskIdSet[event.taskId] == UploadStatus.loading) {
    //     final statusCode = event.statusCode;
    //     if (statusCode != null && statusCode >= 200 && statusCode < 400) {
    //       _taskIdSet[event.taskId] = UploadStatus.done;
    //       add(CreateMediaItem(uploadToken: event.response!));
    //     } else {
    //       _taskIdSet[event.taskId] = UploadStatus.error;
    //     }
    //   }
    // });
  }

  int get _current => _taskIdSet.entries.fold(
      0,
      (previousValue, element) => element.value != UploadStatus.loading
          ? previousValue++
          : previousValue);

  void setOnMediaItemPressed(void Function(MediaItem) onMediaItemPressed) {
    this.onMediaItemPressed = onMediaItemPressed;
  }

  @override
  Future<void> close() async {
    super.close();
    _uploadSubscription.cancel();
  }

  FutureOr<void> _onGetMediaItems(
    GetMediaItems event,
    Emitter<PhotoListState> emit,
  ) async {
    final loadType = event.loadType;
    final albumId = event.albumId;
    final nextPageToken = event.nextPageToken;
    emit(PhotoListLoading(isLoading: true, loadType: loadType));

    try {
      late final GetListMediaItemResponse response;
      if (albumId == null) {
        response = await _googlePhotoRepository.getMediaItems(
          pageToken: nextPageToken,
        );
      } else {
        response = await _googlePhotoRepository.searchMediaItems(
          albumId: albumId,
          pageToken: nextPageToken,
        );
      }

      emit(PhotoListMediaItemLoaded(
        mediaItemViews: _mediaItemFactory.generateMediaItemViews(
          response.mediaItems ?? [],
          onMediaItemPressed,
        ),
        mediaItems: response.mediaItems ?? [],
        loadType: loadType,
        nextPageToken: response.nextPageToken,
      ));
    } catch (e) {
      _onError(e, emit);
      emit(PhotoListMediaItemLoaded(
        loadType: loadType,
        hasError: true,
      ));
    } finally {
      emit(PhotoListLoading(isLoading: false, loadType: loadType));
    }
  }

  FutureOr<void> _onUploadMedia(
    UploadMedia event,
    Emitter<PhotoListState> emit,
  ) async {
    final mediaList = event.mediaList;
    if (mediaList.isNotEmpty) {
      final tasks = mediaList
          .where((e) => e.file != null)
          .where((e) => e.file!.path.fileName.mineType != null)
          .map((e) => _googlePhotoRepository.uploadMediaItem(
                mimeType: e.file!.path.fileName.mineType!,
                file: e.file!,
              ))
          .toList(growable: false);

      final uploadTokens = await Future.wait(tasks);

      add(CreateMediaItems(uploadTokens: uploadTokens));
      // _taskIdSet.addAll(uploadTokens.fold({}, (previousValue, element) {
      //   previousValue[element] = UploadStatus.loading;
      //   return previousValue;
      // }));
      // add(UpdateUploadStatus(current: 0, total: _taskIdSet.length));
    }
  }

  FutureOr<void> _onUpdateUploadStatus(
    UpdateUploadStatus event,
    Emitter<PhotoListState> emit,
  ) {
    emit(UploadProgress(current: event.current, total: event.total));
  }

  FutureOr<void> _onCreateMediaItem(
    CreateMediaItem event,
    Emitter<PhotoListState> emit,
  ) async {
    try {
      final uploadToken = event.uploadToken;
      if (uploadToken == null) {
        throw Exception();
      }

      await _googlePhotoRepository.createMediaItems(
        newMediaItems: [
          NewMediaItem(
            simpleMediaItem: SimpleMediaItem(
              uploadToken: uploadToken,
            ),
          )
        ],
      );

      add(UpdateUploadStatus(
        current: _current,
        total: _taskIdSet.length,
      ));

      emit(MediaItemCreated());
    } catch (e) {
      _onError(e, emit);
    }
  }

  FutureOr<void> _onCreateMediaItems(
    CreateMediaItems event,
    Emitter<PhotoListState> emit,
  ) async {
    try {
      await _googlePhotoRepository.createMediaItems(
        newMediaItems: event.uploadTokens
            .map((uploadToken) =>
            NewMediaItem(
              simpleMediaItem: SimpleMediaItem(
                uploadToken: uploadToken,
              ),
            ))
            .toList(growable: false),
      );

      emit(MediaItemCreated());
    } catch (e) {
      _onError(e, emit);
    }
  }

  void _onError(Object e, Emitter<PhotoListState> emit) {
    if (e is DioError && e.response?.statusCode == 401) {
      emit(PhotoListError(UnauthorizedError()));
    } else {
      emit(PhotoListError(AppError()));
    }
  }
}
