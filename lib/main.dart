import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sky_track/application/authentication/authentication_bloc.dart';
import 'package:sky_track/application/bloc_observer/bloc_observer.dart';
import 'package:sky_track/application/home/home_bloc.dart';
import 'package:sky_track/application/sign_in/sign_in_bloc.dart';
import 'package:sky_track/application/sign_up/sign_up_bloc.dart';
import 'package:sky_track/application/user/user_bloc.dart';
import 'package:sky_track/application/weather/weather_bloc.dart';
import 'package:sky_track/core/app_theme.dart';
import 'package:sky_track/domain/authentication/auth_service.dart';
import 'package:sky_track/firebase_options.dart';
import 'package:sky_track/infastructure/authentication/firebase_auth_repository.dart';
import 'package:sky_track/presentation/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MyApp(FirebaseAuthRepository()));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp(this.authService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(authService: authService),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            authService: context.read<AuthenticationBloc>().authService,
          ),
        ),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            authService: context.read<AuthenticationBloc>().authService,
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: GetMaterialApp(
        title: 'SKY TRACK',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }
}
