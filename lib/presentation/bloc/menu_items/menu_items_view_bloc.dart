import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/use_cases/items_menu_view_mode/change_items_menu_view_use_case.dart';
import 'package:convertouch/presentation/bloc/abstract_bloc.dart';
import 'package:convertouch/presentation/bloc/menu_items/menu_items_view_event.dart';
import 'package:convertouch/presentation/bloc/menu_items/menu_items_view_states.dart';

abstract class MenuViewModeBloc
    extends ConvertouchBloc<MenuItemsViewEvent, MenuItemsViewState> {
  final ChangeItemsMenuViewUseCase changeItemsMenuViewUseCase;

  MenuViewModeBloc({
    required this.changeItemsMenuViewUseCase,
  }) : super(const MenuItemsViewStateSet(
          pageViewMode: ItemsViewMode.grid,
          iconViewMode: ItemsViewMode.list,
        ));

  @override
  Stream<MenuItemsViewState> mapEventToState(MenuItemsViewEvent event) async* {
    if (event is ChangeMenuItemsView) {
      yield const MenuItemsViewStateSetting();

      final result =
          await changeItemsMenuViewUseCase.execute(event.targetViewMode);

      yield result.fold(
        (error) => MenuItemsViewErrorState(message: error.message),
        (changedViewMode) => MenuItemsViewStateSet(
          pageViewMode: changedViewMode.currentMode,
          iconViewMode: changedViewMode.nextMode,
        ),
      );
    }
  }
}

class UnitGroupsViewModeBloc extends MenuViewModeBloc {
  UnitGroupsViewModeBloc({
    required super.changeItemsMenuViewUseCase,
  });
}

class UnitsViewModeBloc extends MenuViewModeBloc {
  UnitsViewModeBloc({
    required super.changeItemsMenuViewUseCase,
  });
}