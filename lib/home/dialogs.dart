import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../generated/l10n.dart';

Future<List<Media>?> showMediaPicker({
  required BuildContext context,
  List<Media> selectedMediaList = const [],
  MediaCount mediaCount = MediaCount.multiple,
  MediaType mediaType = MediaType.all,
  ActionBarPosition actionBarPosition = ActionBarPosition.top,
  void Function(List<Media> media)? onPicking,
}) {
  return showModalBottomSheet<List<Media>>(
    context: context,
    builder: (context) {
      return MediaPicker(
        mediaList: selectedMediaList,
        onPicked: (selectedList) => Navigator.pop(context, selectedList),
        onCancel: () => Navigator.pop(context),
        onPicking: onPicking,
        mediaCount: mediaCount,
        mediaType: mediaType,
        decoration: PickerDecoration(
          actionBarPosition: actionBarPosition,
          blurStrength: 2,
          completeText: S.current.next,
        ),
      );
    },
  );
}
