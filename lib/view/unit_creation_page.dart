import 'package:convertouch/model/constant.dart';
import 'package:convertouch/model/entity/unit_group_model.dart';
import 'package:convertouch/model/entity/unit_model.dart';
import 'package:convertouch/model/entity/unit_value_model.dart';
import 'package:convertouch/model/util/unit_creation_page_util.dart';
import 'package:convertouch/presenter/bloc/unit_groups_bloc.dart';
import 'package:convertouch/presenter/bloc/units_bloc.dart';
import 'package:convertouch/presenter/events/unit_groups_events.dart';
import 'package:convertouch/presenter/events/units_events.dart';
import 'package:convertouch/view/items_view/item/item.dart';
import 'package:convertouch/view/items_view/item/unit_group_item.dart';
import 'package:convertouch/view/scaffold/bloc_wrappers.dart';
import 'package:convertouch/view/scaffold/scaffold.dart';
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
  final _unitAbbrFieldController = TextEditingController();

  String _unitName = "";
  String _unitAbbr = "";
  String _unitAbbrHint = "";

  @override
  Widget build(BuildContext context) {
    return wrapIntoUnitCreationPageListener(
        context,
        ConvertouchScaffold(
          pageTitle: "New Unit",
          appBarRightWidgets: [
            wrapIntoUnitCreationBloc((unitCreationInitialized) {
              return checkIcon(context, _unitName.isNotEmpty, () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<UnitsBloc>(context).add(AddUnit(
                    unitName: _unitName,
                    unitAbbreviation:
                        _unitAbbr.isNotEmpty ? _unitAbbr : _unitAbbrHint,
                    unitGroup: unitCreationInitialized.unitGroup
                ));
              });
            }),
          ],
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsetsDirectional.fromSTEB(7, 10, 7, 0),
              child: Column(children: [
                wrapIntoUnitCreationBloc((unitCreationStarted) {
                    UnitGroupModel unitGroup = unitCreationStarted.unitGroup;
                    return ConvertouchUnitGroupItem(
                      unitGroup,
                      onTap: () {
                        BlocProvider.of<UnitGroupsBloc>(context).add(
                            FetchUnitGroups(
                                selectedUnitGroupId: unitGroup.id,
                                forPage: unitCreationPageId
                            )
                        );
                      },
                    ).buildForList();
                }),
                const SizedBox(height: 20),
                _buildTextField('Unit Name', _unitNameFieldController,
                    (String value) async {
                  setState(() {
                    _unitName = value;
                    _unitAbbrHint = getInitialUnitAbbreviationFromName(value);
                  });
                }),
                const SizedBox(height: 12),
                _buildTextField('Unit Abbreviation', _unitAbbrFieldController,
                    (String value) async {
                  setState(() {
                    _unitAbbr = value;
                  });
                },
                    maxLength: unitAbbreviationMaxLength,
                    lengthCounterVisible: true,
                    hintTextVisible: true),
                const SizedBox(height: 25),
                wrapIntoUnitCreationBloc((unitCreationStarted) {
                  return LayoutBuilder(builder: (context, constraints) {
                    if (unitCreationStarted.unitForEquivalent != null && _unitName.isNotEmpty) {
                      return Column(children: [
                        horizontalDividerWithText("Set unit value equivalent"),
                        const SizedBox(height: 25),
                        ConvertouchItem.createItem(
                          UnitValueModel(
                            unit: UnitModel(
                              name: _unitName,
                              abbreviation: _unitAbbr.isNotEmpty
                                   ? _unitAbbr
                                   : _unitAbbrHint
                            ),
                            value: "1"
                          ),
                        ).buildForList(),
                        const SizedBox(height: 9),
                        ConvertouchItem.createItem(
                          UnitValueModel(
                            unit: unitCreationStarted.unitForEquivalent!,
                            value: "1",
                          ),
                          onTap: () {
                            BlocProvider.of<UnitsBloc>(context).add(
                              FetchUnits(
                                unitGroupId: unitCreationStarted.unitGroup.id,
                                forPage: unitCreationPageId,
                              )
                            );
                          }
                        ).buildForList(),
                        const SizedBox(height: 25),
                      ]);
                    } else {
                      return const SizedBox();
                    }
                  });
                }),
              ]),
            ),
          ),
        ));
  }

  Widget _buildTextField(
      final String label,
      final TextEditingController controller,
      final void Function(String)? onChangedFunc,
      {int? maxLength,
      bool lengthCounterVisible = false,
      bool hintTextVisible = false}) {
    return TextField(
      maxLength: maxLength,
      obscureText: false,
      controller: controller,
      onChanged: onChangedFunc,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xFF426F99))),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xFF426F99))),
        label: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          child: Text(label, maxLines: 1),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          color: Color(0xFF426F99),
        ),
        hintText: hintTextVisible ? _unitAbbrHint : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        counterText: "",
        suffixText: lengthCounterVisible
            ? '${controller.text.length.toString()}/${maxLength.toString()}'
            : null,
      ),
      style: const TextStyle(
        color: Color(0xFF426F99),
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
    );
  }

  @override
  void dispose() {
    _unitNameFieldController.dispose();
    _unitAbbrFieldController.dispose();
    super.dispose();
  }
}
