import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:injectable/injectable.dart';

import '../authentication/authentication_storage.dart';

@lazySingleton
class GooglePhotoUploadService {
  final FlutterUploader _flutterUploader;
  final String _baseUrl;
  final AuthenticationStorage _authenticationStorage;

  GooglePhotoUploadService(
    this._flutterUploader,
    @Named('BaseUrl') this._baseUrl,
    this._authenticationStorage,
  );

  Future<String> uploadMedias({
    required String mimeType,
    required String filePath,
    String? tag,
  }) async {
    final token = await _authenticationStorage.getAccessToken();

    return _flutterUploader.enqueue(RawUpload(
      url: '$_baseUrl/v1/uploads',
      path: filePath,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/octet-stream',
        'X-Goog-Upload-Content-Type': mimeType,
        'X-Goog-Upload-Protocol': 'raw',
      },
      method: UploadMethod.POST,
      tag: tag,
    ));
  }
  
  Stream<UploadTaskResponse> get uploadResponse$ => _flutterUploader.result;
  Stream<UploadTaskProgress> get uploadProgress$ => _flutterUploader.progress;

  Stream<UploadTaskResponse> uploadResponseById$(String taskId) {
    return _flutterUploader.result.where((event) => event.taskId == taskId);
  }

  Stream<UploadTaskProgress> uploadProgressById$(String taskId) {
    return _flutterUploader.progress.where((event) => event.taskId == taskId);
  }
}
