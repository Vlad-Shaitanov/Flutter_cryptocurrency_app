import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CryptoCurrenciesListApp());
}

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto currency list',
      theme: ThemeData(
        // This is the theme of your application.
        dividerColor: Colors.white54, // Цвет разделителя у списка
        scaffoldBackgroundColor: const Color.fromARGB(250, 31, 31, 31), // Фон для все экранов сразу
        primarySwatch: Colors.yellow, // Дефолтный цвет, если он не задан для каких-то элементов
        listTileTheme: const ListTileThemeData(iconColor: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(250, 31, 31, 31), //Цвет шапки
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          )
        ),
        // В теме возможно нужно убрать const
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20
        ),
          labelSmall: TextStyle(
              color: Color.fromRGBO(24,233, 111, 0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14
          )
        ),
      ),
      // Навигация в приложении
      routes: {
        "/coin": (context) => const CryptoCoinScreen(),
        "/": (context) => const CryptoListScreen(title: "Crypto currency list"), // Дефолтный роут(главная страница приложения)
      },
      // home: const CryptoListScreen(title: 'Crypto currency list'), // Использовать, если нет поля routes

    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        // Here we take the value from the CryptoListScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: const Icon(Icons.arrow_back, color: Colors.white,),
      ),
      body: ListView.separated(

          itemCount: 15, // Сколько будет элементов в списке
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context , i) {
            const coinName = "Bitcoin";

            return ListTile(
              leading: SvgPicture.asset('assets/svg/bitcoin-logo.svg', height: 30, width: 30,), // Иконка в начале элемента списка
              trailing: const Icon(Icons.arrow_forward_ios), // Иконка в конце элемента списка
              onTap: () {
                // Коллбэк, вызываемый при нажатии на элемент списка
                // Навигатор принимает контекст и открывает нужный экран по роуту(Навигация)
                Navigator.of(context).pushNamed("/coin",
                  arguments: coinName, // Передача аргументов в виджет, который находится на роуте
                );
              },
              title: Text(coinName,
                style: theme.textTheme.bodyMedium, // Используем стили из общей темы
                //В данном случае тема приложения зарегистрирована в контексте и доступна во всем дереве приложения
              ),
              subtitle: Text("20000\$",
                  style: theme.textTheme.labelSmall
              ),
            );
          },
      ),
    );
  }
}


class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies(){ // Метод жизненного цикла
    // Вытаскиваем аргументы, переданные при переходе по роуту "/coin"
    final args = ModalRoute.of(context)?.settings.arguments; // Может быть null, поэтому опц.последовательность
    // Проверка на то, переданы ли аргументы и верен ли их формат
    assert(args != null && args is String, "You must provide args!");
    log('isOk');

    coinName = args as String;
    setState(() {}); //Чтобы обновить экран после получения нового заголовка
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(coinName ?? "..."),
      ),
    );
  }
}
