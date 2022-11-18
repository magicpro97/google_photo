import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/shared/extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../../google_photo/google_photo_repository.dart';

part 'album_media_item_view_event.dart';

part 'album_media_item_view_state.dart';

@injectable
class AlbumMediaItemViewBloc
    extends Bloc<AlbumMediaItemViewEvent, AlbumMediaItemViewState> {
  final GooglePhotoRepository _googlePhotoRepository;

  AlbumMediaItemViewBloc(this._googlePhotoRepository)
      : super(const UploadProgress()) {
    on<Upload>(_onUpload);
  }

  FutureOr<void> _onUpload(
    Upload event,
    Emitter<AlbumMediaItemViewState> emit,
  ) async {
    final media = event.mediaItem;
    await _googlePhotoRepository
        .uploadMediaItemV2(
            mimeType: media.file!.path.mineType!,
            file: media.file!,
            onUploadProgress: (current, total) {
              emit(UploadProgress(progress: current / total));
            })
        .then((newItem) {
      emit(UploadProgress(
        progress: 1,
        uploadToken: newItem,
      ));
    }).catchError((error, stackTrace) {
      emit(const UploadProgress(progress: 1, hasError: true));
    });
  }
}
