import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/logic/models/theme.dart';
import 'package:pet_adoption_app/presentation/screens/home_screen.dart';

import 'logic/blocs/bloc/theme_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: state.isDarkTheme ? darkTheme : lightTheme,
              home: const HomeScreen(),
            );
          },
        ));
  }
}
