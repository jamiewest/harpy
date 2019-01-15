import 'package:flutter/material.dart';
import 'package:harpy/blocs/bloc_provider.dart';
import 'package:harpy/blocs/timeline_bloc.dart';
import 'package:harpy/components/screens/main/main_screen.dart';

void main() {
  runApp(BlocProvider<TimelineBloc>(
    bloc: TimelineBloc(),
    child: MaterialApp(
      title: "Harpy",
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
