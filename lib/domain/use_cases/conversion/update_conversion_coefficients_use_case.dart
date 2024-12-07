import 'package:convertouch/domain/model/conversion_item_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/domain/model/use_case_model/input/input_conversion_modify_model.dart';
import 'package:convertouch/domain/use_cases/conversion/abstract_modify_conversion_use_case.dart';

class UpdateConversionCoefficientsUseCase
    extends AbstractModifyConversionUseCase<UpdateConversionCoefficientsDelta> {
  const UpdateConversionCoefficientsUseCase({
    required super.createConversionUseCase,
  });

  @override
  Future<Map<int, ConversionItemModel>> modifyConversionItems({
    required Map<int, ConversionItemModel> conversionItemsMap,
    required UpdateConversionCoefficientsDelta delta,
  }) async {
    conversionItemsMap.updateAll(
      (key, item) => ConversionItemModel.coalesce(
        item,
        unit: UnitModel.coalesce(
          item.unit,
          coefficient: delta.updatedUnitCoefs[item.unit.code],
        ),
      ),
    );
    return conversionItemsMap;
  }
}
