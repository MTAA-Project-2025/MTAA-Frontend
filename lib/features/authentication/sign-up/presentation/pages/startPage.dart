import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*title: Row(
          children: [
            SvgPicture.asset(
              'assets/svgs/small_logo.svg',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 5),
            const Text('Likely')
          ],
        ),*/
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/small_logo.svg', // Replace with your asset path
                  width: 100,
                  height: 100,
                ),
              const SizedBox(width: 5),
              Text('Likely', style: Theme.of(context).textTheme.labelLarge)
            ],),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/start_svg_1.svg', // Replace with your asset path
                        width: 200,
                        height: 200,
                      ),
                      SvgPicture.asset(
                        'assets/svgs/start_svg_3.svg', // Replace with your asset path
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/start_svg_2.svg', // Replace with your asset path
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Likely',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'The best messenger in the world',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 300),
                    child: SizedBox(
                      width: double.infinity, // Occupy all available space
                      child: TextButton(
                        onPressed: () {},
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text(
                          'Sign Up',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 300),
                    child: SizedBox(
                      width: double.infinity, // Occupy all available space
                      child: TextButton(
                        onPressed: () {},
                        style:specialTextButtonThemeData.style,
                        child: Text(
                          'Log In',
                        ),
                      ),
                    ),
                  ),
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}