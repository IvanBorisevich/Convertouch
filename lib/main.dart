import 'dart:developer';

import 'package:convertouch/di.dart' as di;
import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/input/unit_groups_events.dart';
import 'package:convertouch/presentation/bloc/app_bloc.dart';
import 'package:convertouch/presentation/bloc/bloc_observer.dart';
import 'package:convertouch/presentation/bloc/items_search_bloc.dart';
import 'package:convertouch/presentation/bloc/menu_items_view_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_creation_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_groups_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_groups_bloc_for_conversion.dart';
import 'package:convertouch/presentation/bloc/unit_groups_bloc_for_unit_creation.dart';
import 'package:convertouch/presentation/bloc/units_bloc.dart';
import 'package:convertouch/presentation/bloc/units_bloc_for_conversion.dart';
import 'package:convertouch/presentation/bloc/units_bloc_for_unit_creation.dart';
import 'package:convertouch/presentation/bloc/units_conversion_bloc.dart';
import 'package:convertouch/presentation/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ConvertouchBlocObserver();
  await di.init();
  log("Dependencies initialization finished");
  runApp(const ConvertouchApp());
}

class ConvertouchApp extends StatelessWidget {
  const ConvertouchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<ConvertouchAppBloc>()),
        BlocProvider(create: (context) => di.locator<UnitGroupsSearchBloc>()),
        BlocProvider(create: (context) => di.locator<UnitGroupsSearchBlocForConversion>()),
        BlocProvider(create: (context) => di.locator<UnitGroupsSearchBlocForUnitCreation>()),
        BlocProvider(create: (context) => di.locator<UnitsSearchBloc>()),
        BlocProvider(create: (context) => di.locator<UnitsSearchBlocForConversion>()),
        BlocProvider(create: (context) => di.locator<UnitsSearchBlocForUnitCreation>()),
        BlocProvider(create: (context) => di.locator<UnitGroupsViewModeBloc>()),
        BlocProvider(create: (context) => di.locator<UnitsViewModeBloc>()),
        BlocProvider(create: (context) => di.locator<UnitsConversionBloc>()),
        BlocProvider(
          create: (context) =>
              di.locator<UnitGroupsBloc>()..add(const FetchUnitGroups()),
        ),
        BlocProvider(
            create: (context) => di.locator<UnitGroupsBlocForConversion>()),
        BlocProvider(
            create: (context) => di.locator<UnitGroupsBlocForUnitCreation>()),
        BlocProvider(create: (context) => di.locator<UnitsBloc>()),
        BlocProvider(create: (context) => di.locator<UnitsBlocForConversion>()),
        BlocProvider(
            create: (context) => di.locator<UnitsBlocForUnitCreation>()),
        BlocProvider(create: (context) => di.locator<UnitCreationBloc>()),
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: quicksandFontFamily),
        home: const ConvertouchScaffold(),
      ),
    );
  }
}
