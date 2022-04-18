import 'package:clockapp/screens/home.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_cubit.dart';
import 'bloc/app_states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clock App',
        theme: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(color: Colors.grey))),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)),
        home: BlocProvider(
          create: (context) => AppCubit(InitialAppState()),
          child: Home(),
        ));
  }
}
