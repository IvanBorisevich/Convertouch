import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/presentation/bloc/app/app_bloc.dart';
import 'package:convertouch/presentation/bloc/app/app_event.dart';
import 'package:convertouch/presentation/bloc/bloc_wrappers.dart';
import 'package:convertouch/presentation/bloc/unit_creation_page/unit_creation_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_creation_page/unit_creation_events.dart';
import 'package:convertouch/presentation/bloc/units_page/units_bloc.dart';
import 'package:convertouch/presentation/bloc/units_page/units_events.dart';
import 'package:convertouch/presentation/ui/pages/templates/units_page.dart';
import 'package:convertouch/presentation/ui/scaffold_widgets/floating_action_button.dart';
import 'package:convertouch/presentation/ui/style/colors.dart';
import 'package:convertouch/presentation/ui/style/model/color_variation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertouchUnitsPageRegular extends StatelessWidget {
  const ConvertouchUnitsPageRegular({super.key});

  @override
  Widget build(BuildContext context) {
    return appBloc((appState) {
      FloatingButtonColorVariation floatingButtonColor =
          unitsPageFloatingButtonColors[appState.theme]!;

      return unitsBloc((pageState) {
        return ConvertouchUnitsPage(
          pageTitle: pageState.unitGroup!.name,
          units: pageState.units,
          appBarRightWidgets: const [],
          onUnitTap: (unit) {},
          onUnitTapForRemoval: (unit) {
            BlocProvider.of<ConvertouchAppBloc>(context).add(
              SelectMenuItemForRemoval(
                itemId: unit.id!,
                selectedItemIdsForRemoval: appState.selectedItemIdsForRemoval,
              ),
            );
          },
          onUnitLongPress: (unit) {
            if (!appState.removalMode) {
              BlocProvider.of<ConvertouchAppBloc>(context).add(
                SelectMenuItemForRemoval(
                  itemId: unit.id!,
                ),
              );
            }
          },
          onUnitsRemove: () {
            BlocProvider.of<UnitsBloc>(context).add(
              RemoveUnits(
                ids: appState.selectedItemIdsForRemoval,
                unitGroup: pageState.unitGroup!,
              ),
            );
          },
          itemIdsSelectedForRemoval: appState.selectedItemIdsForRemoval,
          removalModeAllowed: true,
          removalModeEnabled: appState.removalMode,
          markedUnitsForConversionVisible: false,
          markUnitsOnTap: false,
          markedUnitIdsForConversion: null,
          selectedUnitVisible: false,
          selectedUnitId: null,
          floatingButton: ConvertouchFloatingActionButton.adding(
            onClick: () {
              BlocProvider.of<UnitCreationBloc>(context).add(
                PrepareUnitCreation(
                  unitGroup: pageState.unitGroup,
                  baseUnit: null,
                ),
              );
              Navigator.of(context).pushNamed(unitCreationPage);
            },
            background: floatingButtonColor.background,
            foreground: floatingButtonColor.foreground,
          ),
        );
      });
    });
  }
}
