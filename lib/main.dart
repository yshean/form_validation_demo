import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/material.dart';
import 'package:form_validation_simple/sign_up/sign_up.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late KeyValueStorage _keyValueStorage;
  late FavQsApi _favQsApi;
  late UserRepository _userRepository;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    _keyValueStorage = KeyValueStorage();
    _favQsApi = FavQsApi(
      userTokenSupplier: () => _userRepository.getUserToken(),
    );
    _userRepository = UserRepository(
      remoteApi: _favQsApi,
      noSqlStorage: _keyValueStorage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black54),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
            ),
            suffixIconColor: Colors.greenAccent),
      ),
      home: SignUpScreen(
        userRepository: _userRepository,
        onSignUpSuccess: (username) {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text('Welcome to the club, $username'),
            ),
          );
        },
      ),
    );
  }
}
