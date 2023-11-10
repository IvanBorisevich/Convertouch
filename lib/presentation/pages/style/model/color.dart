import 'package:convertouch/presentation/pages/style/model/color_variation.dart';

abstract class ConvertouchColor<T extends ConvertouchColorVariation> {
  final T regular;
  final T marked;
  final T selected;
  final T focused;

  const ConvertouchColor({
    required this.regular,
    required this.marked,
    required this.selected,
    required this.focused,
  });
}

class ConvertouchMenuItemColor
    extends ConvertouchColor<MenuItemColorVariation> {
  const ConvertouchMenuItemColor({
    required super.regular,
    super.marked = defaultMenuItemColor,
    super.selected = defaultMenuItemColor,
    super.focused = defaultMenuItemColor,
  });
}

class ConvertouchTextBoxColor extends ConvertouchColor<TextBoxColorVariation> {
  const ConvertouchTextBoxColor({
    required super.regular,
    super.marked = defaultTextBoxColor,
    super.selected = defaultTextBoxColor,
    super.focused = defaultTextBoxColor,
  });
}

class ConvertouchConversionItemColor {
  final ConvertouchTextBoxColor textBox;
  final ConvertouchMenuItemColor unitButton;

  const ConvertouchConversionItemColor({
    required this.textBox,
    required this.unitButton,
  });
}

class ConvertouchScaffoldColor
    extends ConvertouchColor<ScaffoldColorVariation> {
  const ConvertouchScaffoldColor({
    required super.regular,
    super.marked = defaultScaffoldColor,
    super.selected = defaultScaffoldColor,
    super.focused = defaultScaffoldColor,
  });
}

class ConvertouchSearchBarColor
    extends ConvertouchColor<SearchBarColorVariation> {
  const ConvertouchSearchBarColor({
    required super.regular,
    super.marked = defaultSearchBarColor,
    super.selected = defaultSearchBarColor,
    super.focused = defaultSearchBarColor,
  });
}

class ConvertouchSideMenuColor
    extends ConvertouchColor<SideMenuColorVariation> {
  const ConvertouchSideMenuColor({
    required super.regular,
    super.marked = defaultSideMenuColor,
    super.selected = defaultSideMenuColor,
    super.focused = defaultSideMenuColor,
  });
}