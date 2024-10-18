import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/unit_group_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/domain/model/value_model.dart';
import 'package:convertouch/domain/utils/formula_utils.dart';
import 'package:equatable/equatable.dart';

class ConversionRule extends Equatable {
  static const ConversionRule none = ConversionRule._();

  final ValueModel unitValue;
  final UnitModel argUnit;
  final ValueModel draftArgValue;
  final ValueModel savedArgValue;
  final bool configVisible;
  final bool configEditable;
  final String? readOnlyDescription;
  final UnitModel primaryBaseUnit;
  final UnitModel secondaryBaseUnit;

  const ConversionRule._({
    this.unitValue = ValueModel.none,
    this.argUnit = UnitModel.none,
    this.draftArgValue = ValueModel.none,
    this.savedArgValue = ValueModel.none,
    this.configVisible = false,
    this.configEditable = false,
    this.readOnlyDescription = "",
    this.primaryBaseUnit = UnitModel.none,
    this.secondaryBaseUnit = UnitModel.none,
  });

  factory ConversionRule.build({
    required UnitGroupModel unitGroup,
    required UnitModel draftUnit,
    required bool mandatoryParamsFilled,
    ValueModel draftUnitValue = ValueModel.one,
    UnitModel argUnit = UnitModel.none,
    ValueModel draftArgValue = ValueModel.one,
    ValueModel savedArgValue = ValueModel.one,
    UnitModel primaryBaseUnit = UnitModel.none,
    UnitModel secondaryBaseUnit = UnitModel.none,
  }) {
    bool editMode = !draftUnit.oob;

    bool isNewFirstUnitInGroup = !primaryBaseUnit.exists;
    bool isEditSingleUnitInGroup = primaryBaseUnit.exists &&
        !secondaryBaseUnit.exists &&
        draftUnit.id == primaryBaseUnit.id;

    bool isBaseConversionRule =
        isNewFirstUnitInGroup || isEditSingleUnitInGroup;

    bool showNonBaseConversionRuleDescription =
        !editMode || unitGroup.conversionType == ConversionType.formula;

    bool readOnlyDescriptionVisible =
        isBaseConversionRule || showNonBaseConversionRuleDescription;

    String? configReadOnlyDescription = readOnlyDescriptionVisible
        ? _getConversionDesc(
            unitGroup: unitGroup,
            draftUnit: draftUnit,
            argUnit: argUnit,
            argValue: draftArgValue,
            secondaryBaseUnit: secondaryBaseUnit,
            isBaseConversionRule: isBaseConversionRule,
            mandatoryParamsFilled: mandatoryParamsFilled,
            showNonBaseConversionRule: showNonBaseConversionRuleDescription,
          )
        : null;

    bool configVisible = mandatoryParamsFilled && !readOnlyDescriptionVisible;

    bool configEditable = configVisible;

    return ConversionRule._(
      unitValue: draftUnitValue,
      argUnit: argUnit,
      draftArgValue: draftArgValue,
      savedArgValue: savedArgValue,
      configVisible: configVisible,
      configEditable: configEditable,
      readOnlyDescription: configReadOnlyDescription,
      primaryBaseUnit: primaryBaseUnit,
      secondaryBaseUnit: secondaryBaseUnit,
    );
  }

  static String _getConversionDesc({
    required UnitGroupModel unitGroup,
    required UnitModel draftUnit,
    required UnitModel argUnit,
    required UnitModel secondaryBaseUnit,
    String unitValue = "1",
    required ValueModel argValue,
    required bool isBaseConversionRule,
    required bool mandatoryParamsFilled,
    required bool showNonBaseConversionRule,
  }) {
    if (unitGroup.conversionType == ConversionType.formula) {
      String? result = FormulaUtils.getReverseStr(
        unitGroupName: unitGroup.name,
        unitCode: draftUnit.code,
      );
      return result ?? noConversionRule;
    }

    if (isBaseConversionRule) {
      return baseUnitConversionRule;
    }

    if (mandatoryParamsFilled && showNonBaseConversionRule) {
      String argUnitCode =
          draftUnit.id != argUnit.id ? argUnit.code : secondaryBaseUnit.code;
      return "$unitValue ${draftUnit.code} = "
          "${argValue.scientific} $argUnitCode";
    }

    return noConversionRule;
  }

  ConversionRule.coalesce(
    ConversionRule saved, {
    ValueModel? unitValue,
    UnitModel? argUnit,
    ValueModel? draftArgValue,
    ValueModel? savedArgValue,
  }) : this._(
          unitValue: unitValue ?? saved.unitValue,
          argUnit: argUnit ?? saved.argUnit,
          draftArgValue: draftArgValue ?? saved.draftArgValue,
          savedArgValue: savedArgValue ?? saved.savedArgValue,
          configVisible: saved.configVisible,
          configEditable: saved.configEditable,
          readOnlyDescription: saved.readOnlyDescription,
          primaryBaseUnit: saved.primaryBaseUnit,
          secondaryBaseUnit: saved.secondaryBaseUnit,
        );

  @override
  List<Object?> get props => [
        unitValue,
        argUnit,
        draftArgValue,
        savedArgValue,
        configVisible,
        configEditable,
        readOnlyDescription,
        primaryBaseUnit,
        secondaryBaseUnit,
      ];

  @override
  String toString() {
    return 'ConversionRule{'
        'unitValue: $unitValue, '
        'argUnit: $argUnit, '
        'draftArgValue: $draftArgValue, '
        'savedArgValue: $savedArgValue, '
        'configVisible: $configVisible, '
        'configEditable: $configEditable, '
        'readOnlyDescription: $readOnlyDescription, '
        'primaryBaseUnit: $primaryBaseUnit, '
        'secondaryBaseUnit: $secondaryBaseUnit}';
  }
}