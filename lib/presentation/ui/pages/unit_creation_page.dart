import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/conversion_item_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/domain/model/use_case_model/input/input_unit_creation_model.dart';
import 'package:convertouch/presentation/bloc/bloc_wrappers.dart';
import 'package:convertouch/presentation/bloc/unit_groups_page/unit_groups_bloc_for_unit_creation.dart';
import 'package:convertouch/presentation/bloc/unit_groups_page/unit_groups_events.dart';
import 'package:convertouch/presentation/bloc/units_page/units_bloc.dart';
import 'package:convertouch/presentation/bloc/units_page/units_bloc_for_unit_creation.dart';
import 'package:convertouch/presentation/bloc/units_page/units_events.dart';
import 'package:convertouch/presentation/bloc/units_page/units_states.dart';
import 'package:convertouch/presentation/ui/animation/fade_scale_animation.dart';
import 'package:convertouch/presentation/ui/pages/templates/basic_page.dart';
import 'package:convertouch/presentation/ui/scaffold_widgets/floating_action_button.dart';
import 'package:convertouch/presentation/ui/scaffold_widgets/items_view/item/conversion_item.dart';
import 'package:convertouch/presentation/ui/scaffold_widgets/items_view/item/menu_item.dart';
import 'package:convertouch/presentation/ui/scaffold_widgets/textbox.dart';
import 'package:convertouch/presentation/ui/style/colors.dart';
import 'package:convertouch/presentation/ui/style/model/color_variation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertouchUnitCreationPage extends StatefulWidget {
  const ConvertouchUnitCreationPage({super.key});

  @override
  State createState() => _ConvertouchUnitCreationPageState();
}

class _ConvertouchUnitCreationPageState
    extends State<ConvertouchUnitCreationPage> {
  final _unitNameFieldController = TextEditingController();
  final _unitCodeFieldController = TextEditingController();

  String _unitName = "";
  String _unitCode = "";
  String _unitCodeHint = "";

  String _newUnitValue = "";
  String _baseUnitValue = "";

  @override
  Widget build(BuildContext context) {
    return appBlocBuilder((appState) {
      ButtonColorVariation floatingButtonColor =
          unitsPageFloatingButtonColors[appState.theme]!;

      return BlocListener<UnitsBloc, UnitsState>(
        listener: (_, unitsState) {
          if (unitsState is UnitExists) {
            showAlertDialog(
                context, "Unit '${unitsState.unitName}' already exist");
          } else if (unitsState is UnitsFetched) {
            Navigator.of(context).pop();
          }
        },
        child: unitCreationBlocBuilder((pageState) {
          return ConvertouchPage(
            appState: appState,
            title: "Add Unit",
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(7, 10, 7, 60),
                child: Column(
                  children: [
                    pageState.unitGroup != null
                        ? ConvertouchMenuItem(
                            pageState.unitGroup!,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<UnitGroupsBlocForUnitCreation>(
                                context,
                              ).add(
                                FetchUnitGroupsForUnitCreation(
                                  currentUnitGroupInUnitCreation:
                                      pageState.unitGroup!,
                                  searchString: null,
                                ),
                              );
                              Navigator.of(context).pushNamed(
                                PageName.unitGroupsPageForUnitCreation.name,
                              );
                            },
                            theme: appState.theme,
                            itemsViewMode: ItemsViewMode.list,
                          )
                        : empty(),
                    const SizedBox(height: 20),
                    ConvertouchTextBox(
                      label: 'Unit Name',
                      controller: _unitNameFieldController,
                      onChanged: (String value) async {
                        setState(() {
                          _unitName = value;
                          _unitCodeHint = _getInitialUnitCodeByName(value);
                        });
                      },
                      theme: appState.theme,
                    ),
                    const SizedBox(height: 12),
                    ConvertouchTextBox(
                      label: 'Unit Code',
                      controller: _unitCodeFieldController,
                      onChanged: (String value) async {
                        setState(() {
                          _unitCode = value;
                        });
                      },
                      maxTextLength: _unitCodeMaxLength,
                      textLengthCounterVisible: true,
                      hintText: _unitCodeHint,
                      theme: appState.theme,
                    ),
                    const SizedBox(height: 25),
                    pageState.baseUnit != null
                        ? Column(
                            children: [
                              ConvertouchFadeScaleAnimation(
                                duration: const Duration(milliseconds: 150),
                                reverse: !_unitName.isNotEmpty,
                                child: _horizontalDividerWithText(
                                  "New conversion rule",
                                  appState.theme,
                                ),
                              ),
                              const SizedBox(height: 25),
                              ConvertouchFadeScaleAnimation(
                                duration: const Duration(milliseconds: 150),
                                reverse: !_unitName.isNotEmpty,
                                child: ConvertouchConversionItem(
                                  ConversionItemModel.fromStrValue(
                                    unit: UnitModel(
                                      name: _unitName,
                                      code: _unitCode.isNotEmpty
                                          ? _unitCode
                                          : _unitCodeHint,
                                      unitGroupId: pageState.unitGroup!.id!,
                                    ),
                                    strValue: _newUnitValue,
                                  ),
                                  onValueChanged: (value) {
                                    setState(() {
                                      _newUnitValue = value;
                                    });
                                  },
                                  theme: appState.theme,
                                ),
                              ),
                              const SizedBox(height: 9),
                              ConvertouchFadeScaleAnimation(
                                duration: const Duration(milliseconds: 150),
                                reverse: !_unitName.isNotEmpty,
                                child: ConvertouchConversionItem(
                                  ConversionItemModel.fromStrValue(
                                    unit: pageState.baseUnit!,
                                    strValue: _baseUnitValue,
                                  ),
                                  onValueChanged: (value) {
                                    setState(() {
                                      _baseUnitValue = value;
                                    });
                                  },
                                  onTap: () {
                                    BlocProvider.of<UnitsBlocForUnitCreation>(
                                      context,
                                    ).add(
                                      FetchUnitsForUnitCreation(
                                        unitGroup: pageState.unitGroup!,
                                        currentSelectedBaseUnit:
                                            pageState.baseUnit,
                                        searchString: null,
                                      ),
                                    );
                                    Navigator.of(context).pushNamed(
                                      PageName.unitsPageForUnitCreation.name,
                                    );
                                  },
                                  theme: appState.theme,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          )
                        : ConvertouchFadeScaleAnimation(
                            duration: const Duration(milliseconds: 150),
                            child: _infoBox(pageState.comment!),
                          ),
                  ],
                ),
              ),
            ),
            floatingActionButton: ConvertouchFloatingActionButton(
              icon: Icons.check_outlined,
              visible: _unitName.isNotEmpty,
              onClick: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<UnitsBloc>(context).add(
                  AddUnit(
                    unitCreationParams: InputUnitCreationModel(
                      unitGroup: pageState.unitGroup!,
                      newUnitName: _unitName,
                      newUnitCode:
                          _unitCode.isNotEmpty ? _unitCode : _unitCodeHint,
                      newUnitValue: _newUnitValue,
                      baseUnit: pageState.baseUnit,
                      baseUnitValue: _baseUnitValue,
                    ),
                  ),
                );
              },
              background: floatingButtonColor.background,
              foreground: floatingButtonColor.foreground,
            ),
          );
        }),
      );
    });
  }

  @override
  void dispose() {
    _unitNameFieldController.dispose();
    _unitCodeFieldController.dispose();
    super.dispose();
  }
}

Widget _horizontalDividerWithText(String text, ConvertouchUITheme theme) {
  Color dividerColor = dividerWithTextColors[theme]!;

  Widget divider() {
    return Expanded(
      child: Divider(
        color: dividerColor,
        thickness: 1.2,
      ),
    );
  }

  return Row(children: [
    divider(),
    const SizedBox(width: 7),
    Text(
      text,
      style: TextStyle(
        color: dividerColor,
        fontWeight: FontWeight.w500,
      ),
    ),
    const SizedBox(width: 7),
    divider(),
  ]);
}

Widget _infoBox(String comment) {
  return Container(
    padding: const EdgeInsetsDirectional.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xFFE7EFFF),
    ),
    child: Column(
      children: [
        const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Color(0xFF345E85),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 5,
              ),
              child: Center(
                child: Text(
                  "Note",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345E85),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            comment,
            style: const TextStyle(
              color: Color(0xFF426F99),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

const int _unitCodeMaxLength = 4;

String _getInitialUnitCodeByName(String unitName) {
  return unitName.length > _unitCodeMaxLength
      ? unitName.substring(0, _unitCodeMaxLength)
      : unitName;
}
