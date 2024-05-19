import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/item_model.dart';
import 'package:convertouch/domain/utils/object_utils.dart';

class UnitModel extends IdNameItemModel {
  static const UnitModel none = UnitModel._();

  final String code;
  final double? coefficient;
  final String? symbol;
  final int unitGroupId;
  final ConvertouchValueType? valueType;
  final double? minValue;
  final double? maxValue;

  const UnitModel({
    super.id,
    required super.name,
    required this.code,
    this.coefficient,
    this.symbol,
    this.unitGroupId = -1,
    this.valueType,
    this.minValue,
    this.maxValue,
    super.oob,
  }) : super(
          itemType: ItemType.unit,
        );

  const UnitModel._()
      : this(
          name: "",
          code: "",
        );

  UnitModel.coalesce(
    UnitModel savedUnit, {
    int? id,
    String? name,
    String? code,
    double? coefficient,
    String? symbol,
    int? unitGroupId,
    ConvertouchValueType? valueType,
    double? minValue,
    double? maxValue,
  }) : this(
          id: ObjectUtils.coalesce(
            what: savedUnit.id,
            patchWith: id,
          ),
          name: ObjectUtils.coalesce(
                what: savedUnit.name,
                patchWith: name,
              ) ??
              "",
          code: ObjectUtils.coalesce(
                what: savedUnit.code,
                patchWith: code,
              ) ??
              "",
          coefficient: ObjectUtils.coalesce(
            what: savedUnit.coefficient,
            patchWith: coefficient,
          ),
          symbol: ObjectUtils.coalesce(
            what: savedUnit.symbol,
            patchWith: symbol,
          ),
          valueType: ObjectUtils.coalesce(
            what: savedUnit.valueType,
            patchWith: valueType,
          ),
          minValue: ObjectUtils.coalesce(
            what: savedUnit.minValue,
            patchWith: minValue,
          ),
          maxValue: ObjectUtils.coalesce(
            what: savedUnit.maxValue,
            patchWith: maxValue,
          ),
          unitGroupId: ObjectUtils.coalesce(
                what: savedUnit.unitGroupId,
                patchWith: unitGroupId,
              ) ??
              -1,
          oob: savedUnit.oob,
        );

  bool get empty => this == none;

  bool get notEmpty => this != none;

  bool get named => name.isNotEmpty;

  bool get unnamed => name.isEmpty;

  Map<String, dynamic> toJson() {
    var result = {
      "id": id,
      "name": name,
      "code": code,
      "coefficient": coefficient,
      "symbol": symbol,
      "unitGroupId": unitGroupId != -1 ? unitGroupId : null,
      "valueType": valueType?.val,
      "minValue": minValue,
      "maxValue": maxValue,
      "oob": oob == true ? true : null,
    };

    result.removeWhere((key, value) => value == null);

    return result;
  }

  static UnitModel? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return UnitModel(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      coefficient: json["coefficient"],
      symbol: json["symbol"],
      unitGroupId: json["unitGroupId"] ?? -1,
      valueType: ConvertouchValueType.valueOf(json["valueType"]),
      minValue: json["minValue"],
      maxValue: json["maxValue"],
      oob: json["oob"] == true,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        itemType,
        coefficient,
        code,
        symbol,
        unitGroupId,
        valueType,
        minValue,
        maxValue,
        oob,
      ];

  @override
  String toString() {
    if (this == UnitModel.none) {
      return "UnitModel.none";
    }
    return 'UnitModel{'
        'id: $id, $code, $name, c: $coefficient, '
        'groupId: $unitGroupId, oob: $oob, type: $valueType}';
  }
}
