import 'package:equatable/equatable.dart';

abstract class UnitGroupsEvent extends Equatable {
  const UnitGroupsEvent();

  @override
  List<Object?> get props => [];
}

class FetchUnitGroups extends UnitGroupsEvent {
  const FetchUnitGroups();

  @override
  String toString() {
    return 'FetchUnitGroups{}';
  }
}

class PrepareUnitGroupCreation extends UnitGroupsEvent {
  const PrepareUnitGroupCreation();

  @override
  String toString() {
    return 'PrepareUnitGroupCreation{}';
  }
}

class RemoveUnitGroups extends UnitGroupsEvent {
  final List<int> ids;

  const RemoveUnitGroups({
    required this.ids,
  });

  @override
  List<Object> get props => [
    ids,
    super.props,
  ];

  @override
  String toString() {
    return 'RemoveUnitGroups{'
        'ids: $ids}';
  }
}