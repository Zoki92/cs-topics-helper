import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:cs_topics_app/bloc/infinite_scroll_bloc/infinite_scroll_bloc.dart';
import 'package:cs_topics_app/repository/data_structure_repository.dart';
import 'package:cs_topics_app/views/app_started_views/starter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependencies/dependency_injection.dart';

void main() {
  setDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnAppStartBloc>(
          create: (context) => OnAppStartBloc()..add(AppStarted()),
        ),
        BlocProvider<InfiniteScrollBloc>(
          create: (context) =>
              InfiniteScrollBloc(di.get<DataStructureRepository>())
                ..add(FetchData()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CS topic app',
        home: StartView(),
      ),
    );
  }
}
