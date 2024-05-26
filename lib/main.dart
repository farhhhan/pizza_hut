import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';
import 'package:pizza_app/bloc/pizzaadd_bloc.dart';
import 'package:pizza_app/cartbloc/bloc/cart_bloc.dart';
import 'package:pizza_app/choice/bloc/select_bloc.dart';
import 'package:pizza_app/count/bloc/count_bloc.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/home.dart';
import 'package:pizza_app/image/imagerepo.dart';
import 'package:pizza_app/image/img_bloc_bloc.dart';
import 'package:pizza_app/location/bloc/autho_complete_bloc.dart';
import 'package:pizza_app/location/searcgRepo.dart';
import 'package:pizza_app/userBloc/bloc/user_bloc.dart';
import 'package:pizza_app/welocme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create:(context) => PizzaaddBloc()),
      BlocProvider(create:(context) => AuthBloc()),
       BlocProvider(create:(context) => UserBloc()),
       BlocProvider(create:(context) => ImgBlocBloc(ImagePickerServices())),
       BlocProvider(create:(context) => CountBloc()),
       BlocProvider(create:(context) => SelectBloc()),
       BlocProvider(create:(context) => CartBloc()),
       BlocProvider(create:(context) => AuthoCompleteBloc(SearchRepo()))
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF0A1529),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFB325),
            secondary: const Color(0xFFFFB325)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    ));
  }
}
