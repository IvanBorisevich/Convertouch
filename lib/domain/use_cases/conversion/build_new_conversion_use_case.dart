import 'dart:developer';

import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/conversion_item_model.dart';
import 'package:convertouch/domain/model/exception_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/domain/model/use_case_model/input/input_conversion_model.dart';
import 'package:convertouch/domain/model/use_case_model/output/output_conversion_model.dart';
import 'package:convertouch/domain/model/value_model.dart';
import 'package:convertouch/domain/repositories/dynamic_value_repository.dart';
import 'package:convertouch/domain/use_cases/use_case.dart';
import 'package:convertouch/domain/utils/formula_utils.dart';
import 'package:convertouch/domain/utils/object_utils.dart';
import 'package:convertouch/domain/utils/value_model_utils.dart';
import 'package:either_dart/either.dart';

class BuildNewConversionUseCase
    extends UseCase<InputConversionModel, OutputConversionModel> {
  final DynamicValueRepository dynamicValueRepository;

  const BuildNewConversionUseCase({
    required this.dynamicValueRepository,
  });

  @override
  Future<Either<ConvertouchException, OutputConversionModel>> execute(
    InputConversionModel input,
  ) async {
    try {
      if (input.targetUnits.isEmpty) {
        return Right(OutputConversionModel.noItems(input.unitGroup));
      }

      ConversionItemModel srcItem = await _getSourceConversionItem(input);

      List<ConversionItemModel> convertedUnitValues = [];
      double? srcValue = double.tryParse(srcItem.value.str);
      double srcDefaultValue = double.parse(srcItem.defaultValue.str);
      double srcCoefficient = srcItem.unit.coefficient!;

      for (UnitModel tgtUnit in input.targetUnits) {
        if (tgtUnit.id == srcItem.unit.id) {
          convertedUnitValues.add(srcItem);
          continue;
        }

        double? tgtValue;
        double tgtDefaultValue;

        if (input.unitGroup.conversionType != ConversionType.formula) {
          double tgtCoefficient = tgtUnit.coefficient!;
          tgtValue = srcValue != null
              ? srcValue * srcCoefficient / tgtCoefficient
              : null;
          tgtDefaultValue = srcDefaultValue * srcCoefficient / tgtCoefficient;
        } else {
          String groupName = input.unitGroup.name;

          var srcToBase = FormulaUtils.getFormula(
            unitGroupName: groupName,
            unitCode: srcItem.unit.code,
          );
          var baseToTgt = FormulaUtils.getFormula(
            unitGroupName: groupName,
            unitCode: tgtUnit.code,
          );

          double? baseValue = srcToBase.applyForward(srcValue);
          double? normalizedBaseValue = srcToBase.applyForward(srcDefaultValue);

          tgtValue = baseToTgt.applyReverse(baseValue);
          tgtDefaultValue = baseToTgt.applyReverse(normalizedBaseValue)!;
        }

        log("tgt unit name: ${tgtUnit.name}, tgtValue: $tgtValue, tgtDefaultValue: $tgtDefaultValue");

        double? minValue = (tgtUnit.minValue ?? input.unitGroup.minValue).num;
        double? maxValue = (tgtUnit.maxValue ?? input.unitGroup.maxValue).num;

        ValueModel tgtValueModel = ValueModelUtils.betweenOrNone(
          rawValue: tgtValue,
          min: minValue,
          max: maxValue,
        );

        ValueModel tgtDefaultValueModel = ValueModelUtils.betweenOrNone(
          rawValue: tgtDefaultValue,
          min: minValue,
          max: maxValue,
        );

        convertedUnitValues.add(
          ConversionItemModel(
            unit: tgtUnit,
            value: tgtValueModel.exists ? tgtValueModel : ValueModel.none,
            defaultValue: tgtDefaultValueModel.exists
                ? tgtDefaultValueModel
                : ValueModel.undefined,
          ),
        );
      }

      return Right(
        OutputConversionModel(
          unitGroup: input.unitGroup,
          sourceConversionItem: srcItem,
          targetConversionItems: convertedUnitValues,
        ),
      );
    } catch (e, stackTrace) {
      return Left(
        InternalException(
          message: "Error when converting unit value",
          stackTrace: stackTrace,
          dateTime: DateTime.now(),
        ),
      );
    }
  }

  Future<ConversionItemModel> _getSourceConversionItem(
    InputConversionModel input,
  ) async {
    UnitModel srcUnit =
        input.sourceConversionItem?.unit ?? input.targetUnits.first;
    ValueModel srcValue = input.sourceConversionItem?.value ?? ValueModel.none;
    ValueModel srcDefaultValue = ValueModel.ofString(
      ObjectUtils.tryGet(await dynamicValueRepository.get(srcUnit.id)).value,
    );

    return ConversionItemModel(
      unit: srcUnit,
      value: srcValue,
      defaultValue:
          srcDefaultValue.exists ? srcDefaultValue : ValueModel.undefined,
    );
  }
}
