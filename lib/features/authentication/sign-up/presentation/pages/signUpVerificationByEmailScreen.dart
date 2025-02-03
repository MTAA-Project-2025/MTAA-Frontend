import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class SignUpVerificationByEmailScreen extends StatefulWidget {
  @override
  State<SignUpVerificationByEmailScreen> createState() => _SignUpVerificationByEmailScreenState();
}

class _SignUpVerificationByEmailScreenState extends State<SignUpVerificationByEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin:const EdgeInsets.fromLTRB(0,0,21,0),
            child:IconButton(
            icon: const Icon(Icons.dark_mode),
            tooltip: 'Change theme',
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ))],
      ),
    );
  }
}
