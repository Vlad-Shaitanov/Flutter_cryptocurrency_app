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
      home: const MyHomePage(title: 'Crypto currency list'), // Поле задает главную страницу приложения
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: const Icon(Icons.arrow_back, color: Colors.white,),
      ),
      body: ListView.separated(

          itemCount: 15, // Сколько будет элементов в списке
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context , i) => ListTile(
            leading: SvgPicture.asset('assets/svg/bitcoin-logo.svg', height: 30, width: 30,), // Иконка в начале элемента списка
            trailing: const Icon(Icons.arrow_forward_ios), // Иконка в конце элемента списка
            title: Text("Bitcoin",
              style: theme.textTheme.bodyMedium, // Используем стили из общей темы
              //В данном случае тема приложения зарегистрирована в контексте и доступна во всем дереве приложения
            ),
            subtitle: Text("20000\$",
              style: theme.textTheme.labelSmall
            ),
          )
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
