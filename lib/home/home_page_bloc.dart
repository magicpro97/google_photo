import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:google_photo/google_photo/google_photo.dart';
import 'package:google_photo/shared/extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:uuid/uuid.dart';

import '../generated/l10n.dart';
import '../google_photo/google_photo_repository.dart';
import '../shared/error.dart';
import 'media_item_factory.dart';
import 'media_item_view/media_item_view.dart';
import 'upload_status.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GooglePhotoRepository _googlePhotoRepository;
  final MediaItemFactory _mediaItemFactory;
  final Uuid _uuid;

  late final StreamSubscription<UploadTaskResponse> _uploadSubscription;

  final _taskIdSet = <String, UploadStatus>{};

  HomePageBloc(
    this._googlePhotoRepository,
    this._mediaItemFactory,
    this._uuid,
  ) : super(const HomePageLoading(false)) {
    on<GetMediaItems>(_onGetMediaItems);
    on<UploadMedia>(_onUploadMedia);
    on<UpdateUploadStatus>(_onUpdateUploadStatus);
    on<CreateMediaItem>(_onCreateMediaItem);

    add(GetMediaItems());

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

  @override
  Future<void> close() async {
    super.close();
    _uploadSubscription.cancel();
  }

  FutureOr<void> _onGetMediaItems(
    GetMediaItems event,
    Emitter<HomePageState> emit,
  ) async {
    emit(const HomePageLoading(true));

    try {
      final response = await _googlePhotoRepository.getMediaItem();

      emit(HomePageMediaItemLoaded(await _mediaItemFactory
          .generateMediaItemViews(response.mediaItems ?? [])));
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        emit(HomePageError(UnauthorizedError('')));
      } else {
        emit(HomePageError(AppError(S.current.something_happened)));
      }
    } finally {
      emit(const HomePageLoading(false));
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
    await _googlePhotoRepository.createMediaItems([
      NewMediaItem(
        description: '',
        simpleMediaItem: SimpleMediaItem(
          fileName: _uuid.v1(),
          uploadToken: event.uploadToken,
        ),
      )
    ]);

    add(UpdateUploadStatus(
      current: _current,
      total: _taskIdSet.length,
    ));

    add(GetMediaItems());
  }
}
