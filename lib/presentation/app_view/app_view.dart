import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/authentication/authentication_bloc.dart';
import 'package:sky_track/application/home/home_bloc.dart';
import 'package:sky_track/presentation/home/home_screen.dart';
import 'package:sky_track/presentation/welcome/welcome_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
