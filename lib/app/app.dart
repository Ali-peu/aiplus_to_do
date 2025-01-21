import 'package:aiplus_to_do/todo/bloc/to_do_bloc.dart';
import 'package:aiplus_to_do/todo/repo/shared_pref_local_db.dart';
import 'package:aiplus_to_do/todo/ui/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const App({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: BlocProvider(
        create: (context) => ToDoBloc(
            sharedPrefLocalDb:
                SharedPrefLocalDb(sharedPrefInstance: sharedPreferences))
          ..add(FetchData()),
        child: const TaskScreen(),
      ),
    );
  }
}
