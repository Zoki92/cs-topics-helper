import 'package:cs_topics_app/bloc/bloc.dart';
import 'package:cs_topics_app/views/app_started_views/splash_screen.dart';
import 'package:cs_topics_app/views/data_structure_listing/data_structure_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnAppStartBloc, OnAppStartState>(
        builder: (context, state) {
          if (state is OnAppStartLoaded) {
            return DataStructureListView();
          }

          return SplashScreen();
        },
      ),
    );
  }
}
