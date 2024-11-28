import 'package:collection/collection.dart';
import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/unit_group_model.dart';
import 'package:convertouch/presentation/bloc/bloc_wrappers.dart';
import 'package:convertouch/presentation/bloc/common/items_list/items_list_events.dart';
import 'package:convertouch/presentation/bloc/common/items_selection/items_selection_bloc.dart';
import 'package:convertouch/presentation/bloc/common/items_selection/items_selection_events.dart';
import 'package:convertouch/presentation/bloc/common/navigation/navigation_bloc.dart';
import 'package:convertouch/presentation/bloc/common/navigation/navigation_events.dart';
import 'package:convertouch/presentation/bloc/conversion_page/conversion_bloc.dart';
import 'package:convertouch/presentation/bloc/conversion_page/conversion_events.dart';
import 'package:convertouch/presentation/bloc/unit_group_details_page/unit_group_details_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_group_details_page/unit_group_details_events.dart';
import 'package:convertouch/presentation/bloc/units_page/units_bloc.dart';
import 'package:convertouch/presentation/ui/pages/basic_page.dart';
import 'package:convertouch/presentation/ui/style/color/color_scheme.dart';
import 'package:convertouch/presentation/ui/style/color/colors.dart';
import 'package:convertouch/presentation/ui/widgets/floating_action_button.dart';
import 'package:convertouch/presentation/ui/widgets/items_view/conversion_items_view.dart';
import 'package:convertouch/presentation/ui/widgets/refresh_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertouchConversionPage extends StatelessWidget {
  const ConvertouchConversionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final unitsBloc = BlocProvider.of<UnitsBloc>(context);
    final unitsSelectionBloc = BlocProvider.of<ItemsSelectionBloc>(context);
    final unitGroupDetailsBloc = BlocProvider.of<UnitGroupDetailsBloc>(context);
    final conversionBloc = BlocProvider.of<ConversionBloc>(context);
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return appBlocBuilder(
      builderFunc: (appState) {
        PageColorScheme pageColorScheme = pageColors[appState.theme]!;
        ConvertouchColorScheme floatingButtonColor =
            conversionPageFloatingButtonColors[appState.theme]!;

        return singleGroupBlocBuilder(
          builderFunc: (singleGroupState) {
            UnitGroupModel unitGroup = singleGroupState.unitGroup;

            return ConvertouchPage(
              title: unitGroup.name,
              appBarRightWidgets: [
                IconButton(
                  icon: Icon(
                    unitGroup.oob
                        ? Icons.info_outline_rounded
                        : Icons.edit_outlined,
                    color: pageColorScheme.appBar.foreground.regular,
                  ),
                  onPressed: () {
                    unitGroupDetailsBloc.add(
                      GetExistingUnitGroupDetails(
                        unitGroup: unitGroup,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.dashboard_customize_outlined,
                    color: pageColorScheme.appBar.foreground.regular,
                  ),
                  onPressed: () {
                    unitsBloc.add(
                      FetchItems(
                        parentItemId: unitGroup.id,
                        onFirstFetch: () {
                          navigationBloc.add(
                            const NavigateToPage(
                              pageName: PageName.unitsPageRegular,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
              body: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: conversionBlocBuilder(
                  builderFunc: (pageState) {
                    final conversion = pageState.conversion;

                    return ConvertouchConversionItemsView(
                      conversion.targetConversionItems,
                      parentValueType: unitGroup.valueType,
                      onUnitItemTap: (item) {
                        unitsBloc.add(
                          FetchItems(
                            parentItemId: unitGroup.id,
                          ),
                        );

                        unitsSelectionBloc.add(
                          StartItemSelection(
                            previouslySelectedId: item.unit.id,
                            excludedIds: conversion.targetConversionItems
                                .map((e) => e.unit.id)
                                .whereNot((id) => id == item.unit.id)
                                .toList(),
                          ),
                        );

                        navigationBloc.add(
                          const NavigateToPage(
                            pageName: PageName.unitsPageForConversion,
                          ),
                        );
                      },
                      onTextValueChanged: (item, value) {
                        conversionBloc.add(
                          EditConversionItemValue(
                            newValue: value,
                            unitId: item.unit.id,
                          ),
                        );
                      },
                      onItemRemoveTap: (item) {
                        conversionBloc.add(
                          RemoveConversionItems(
                            unitIds: [item.unit.id],
                          ),
                        );
                      },
                      theme: appState.theme,
                    );
                  },
                ),
              ),
              floatingActionButton: conversionBlocBuilder(
                builderFunc: (pageState) {
                  final conversion = pageState.conversion;

                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.end,
                    children: [
                      ConvertouchRefreshFloatingButton(
                        unitGroupName: unitGroup.name,
                        visible: pageState.showRefreshButton,
                      ),
                      ConvertouchFloatingActionButton.adding(
                        onClick: () {
                          unitsBloc.add(
                            FetchItems(
                              parentItemId: unitGroup.id,
                            ),
                          );
                          unitsSelectionBloc.add(
                            StartItemsMarking(
                              previouslyMarkedIds: conversion
                                  .targetConversionItems
                                  .map((unitValue) => unitValue.unit.id)
                                  .toList(),
                              markedItemsMinNumForSelection: 2,
                            ),
                          );
                          navigationBloc.add(
                            const NavigateToPage(
                              pageName: PageName.unitsPageForConversion,
                            ),
                          );
                        },
                        colorScheme: floatingButtonColor,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
