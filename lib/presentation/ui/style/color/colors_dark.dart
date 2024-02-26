import 'package:convertouch/presentation/ui/style/color/color_scheme.dart';
import 'package:convertouch/presentation/ui/style/color/color_variation.dart';
import 'package:convertouch/presentation/ui/style/color/colors.dart';
import 'package:flutter/material.dart';

const pageColorSchemeDark = PageColorScheme(
  appBar: ConvertouchColorScheme(
    background: ColorVariation.only(Color(0xFF2B2F38)),
    foreground: ColorVariation(
      regular: Color(0xFFBDCDDA),
    ),
  ),
  page: ConvertouchColorScheme(
    background: ColorVariation.only(Color(0xFF363D48)),
    foreground: ColorVariation.only(Color(0xFFCCD7E0)),
  ),
  snackBar: SnackBarColorScheme(
    background: ColorVariation.only(Color(0xFF535E6E)),
    foregroundError: ColorVariation.only(Color(0xFFFFAAAA)),
    foregroundWarning: ColorVariation.only(Color(0xFFF1FFB0)),
    foregroundInfo: ColorVariation.only(Color(0xFFF2F8FF)),
  ),
  bottomBar: ConvertouchColorScheme(
    background: ColorVariation.only(Color(0xFF2B2F38)),
    foreground: ColorVariation(
      regular: Color(0xFFCCD7E0),
      disabled: Color(0xFF8D8D8D),
    ),
  ),
);

const searchBarColorSchemeDark = SearchBarColorScheme(
  textBox: TextBoxColorScheme(
    background: ColorVariation.only(Color(0xFF444C59)),
    foreground: ColorVariation.only(Color(0xFFCCD7E0)),
    hint: ColorVariation.only(Color(0xFF8791A1)),
  ),
  viewModeButton: ConvertouchColorScheme(
    background: ColorVariation.only(Color(0xFF444C59)),
    foreground: ColorVariation.only(Color(0xFFCCD7E0)),
  ),
);

const unitGroupItemColorSchemeDark = ConvertouchColorScheme(
  border: ColorVariation(
    regular: Color(0xff5e6981),
    selected: Color(0xFFA5B2FF),
  ),
  background: ColorVariation(
    regular: Color(0xff434c60),
    selected: Color(0xff475065),
  ),
  foreground: ColorVariation(
    regular: Color(0xffa6baee),
    selected: Color(0xffa6baee),
  ),
);

const unitGroupItemInAppBarColorSchemeDark = ConvertouchColorScheme(
  border: ColorVariation.only(Color(0xff5e6981)),
  background: ColorVariation.only(Color(0xff434c60)),
  foreground: ColorVariation.only(Color(0xffa6baee)),
);

const unitItemColorSchemeDark = ConvertouchColorScheme(
  border: ColorVariation(
    regular: Color(0xFF576479),
    marked: Color(0xFF7595B2),
    selected: Color(0xFF7A9EBE),
    // disabled: Color(0x8C6A7885),
  ),
  background: ColorVariation(
    regular: Color(0xFF3E4A5D),
    marked: Color(0xE4415F7E),
    selected: Color(0xE4415F7E),
    // disabled: Color(0x9B3E4A5D),
  ),
  foreground: ColorVariation(
    regular: Color(0xFF7DAAD3),
    marked: Color(0xFF95B8D7),
    selected: Color(0xFFA0CAF1),
    // disabled: Color(0x867DAAD3),
  ),
);

const unitGroupPageInfoBoxColorDark = ConvertouchColorScheme(
  background: ColorVariation.only(Color(0xff434c60)),
);

const unitPageInfoBoxColorDark = ConvertouchColorScheme(
  background: ColorVariation.only(Color(0xFF3E4A5D)),
);

const unitGroupPageEmptyViewColorDark = ConvertouchColorScheme(
  foreground: ColorVariation.only(Color(0xffa6baee)),
);

const unitPageEmptyViewColorDark = ConvertouchColorScheme(
  foreground: ColorVariation.only(Color(0xFF7DAAD3)),
);

const unitTextBoxColorDark = TextBoxColorScheme(
  border: ColorVariation(
    regular: Color(0xFF84A1BD),
    focused: Color(0xFF98BAD9),
  ),
  foreground: ColorVariation(
    regular: Color(0xFF98BAD9),
  ),
  hint: ColorVariation(
    regular: Color(0xFF84A1BD),
  ),
);

const unitGroupTextBoxColorDark = TextBoxColorScheme(
  border: ColorVariation(
    regular: Color(0xFFA5B2FF),
    disabled: Color(0x90A5B2FF),
  ),
  foreground: ColorVariation(
    regular: Color(0xFFA5B2FF),
    disabled: Color(0x90A5B2FF),
  ),
  hint: ColorVariation(
    regular: Color(0x90A5B2FF),
  ),
);

const conversionItemColorSchemeDark = ConversionItemColorScheme(
  textBox: unitTextBoxColorDark,
  background: ColorVariation.only(Color(0xFF373F4B)),
  unitButton: ConvertouchColorScheme(
    border: ColorVariation(
      regular: Color(0xFF708EA8),
      focused: Color(0xFF8FB1D0),
    ),
    background: ColorVariation(
      regular: Color(0xE43F5B77),
    ),
    foreground: ColorVariation(
      regular: Color(0xFF90B3D2),
      focused: Color(0xFF8FB1D0),
    ),
  ),
  handler: ConvertouchColorScheme(
    foreground: ColorVariation.only(Color(0xFF718EA9)),
  ),
);

const unitGroupsPageFloatingButtonColorSchemeDark = ConvertouchColorScheme(
  background: ColorVariation.only(Color(0xFF616491)),
  foreground: ColorVariation.only(Color(0xFFD1CFD3)),
);

const unitsPageFloatingButtonColorSchemeDark = ConvertouchColorScheme(
  background: ColorVariation.only(Color(0xDB446F96)),
  foreground: ColorVariation.only(Color(0xFFD1CFD3)),
);

const conversionPageFloatingButtonColorSchemeDark = ConvertouchColorScheme(
  background: ColorVariation.only(Color(0xA83D6C98)),
  foreground: ColorVariation.only(Color(0xFF9DC0E0)),
);

const refreshButtonColorSchemeDark = ConvertouchColorScheme(
  border: ColorVariation(
    regular: Color(0xFF585A6C),
  ),
  foreground: ColorVariation(
    regular: Color(0xFFBFC3F6),
    disabled: Color(0xFF7E82B4),
  ),
  background: ColorVariation.only(Color(0xFFC9C9F8)),
);

const removalFloatingButtonColorDark = ConvertouchColorScheme(
  border: ColorVariation.only(Color(0xFF373F4B)),
  background: ColorVariation.only(Color(0xFF9D5225)),
  foreground: ColorVariation.only(Color(0xFFDEE9FF)),
);

const settingItemColorDark = SettingItemColorScheme(
  background: ColorVariation(
    regular: Color(0xFF3A4E60),
    selected: Color(0xFF506394),
    disabled: Color(0xFF506394),
  ),
  foreground: ColorVariation(
    regular: Color(0xFFB1D2F1),
    selected: Color(0xFF88A3BD),
    disabled: Color(0xFF6F9ECB),
  ),
  divider: ColorVariation.only(Color(0xFF4D5D83)),
  switcher: SwitcherColorScheme(
    track: ConvertouchColorScheme(
      border: ColorVariation(
        regular: Color(0xFF88A3BD),
        selected: Color(0xFF7FA1C0),
        disabled: Color(0xFF94B4D2),
      ),
      background: ColorVariation(
        regular: noColor,
        selected: Color(0xFF7FA1C0),
        disabled: Color(0xFF94B4D2),
      ),
    ),
  ),
);

const progressIndicatorColorDark = ConvertouchColorScheme(
  foreground: ColorVariation.only(Color(0xFF7272C9)),
);
