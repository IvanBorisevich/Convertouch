import 'package:convertouch/domain/constants.dart';

class ItemsMenuViewModeOutput {
  final ItemsViewMode pageViewMode;
  final ItemsViewMode iconViewMode;

  const ItemsMenuViewModeOutput({
    required this.pageViewMode,
    required this.iconViewMode,
  });
}