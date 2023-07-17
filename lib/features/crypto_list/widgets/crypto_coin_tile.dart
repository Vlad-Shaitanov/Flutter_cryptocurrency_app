import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      // leading: SvgPicture.asset('assets/svg/bitcoin-logo.svg', height: 30, width: 30,), // Иконка в начале элемента списка
      leading: Image.network(coin.imageUrl),
      trailing: const Icon(Icons.arrow_forward_ios), // Иконка в конце элемента списка
      onTap: () {
        // Коллбэк, вызываемый при нажатии на элемент списка
        // Навигатор принимает контекст и открывает нужный экран по роуту(Навигация)
        Navigator.of(context).pushNamed("/coin",
          arguments: coin, // Передача аргументов в виджет, который находится на роуте
        );
      },
      title: Text(coin.name,
        style: theme.textTheme.bodyMedium, // Используем стили из общей темы
        //В данном случае тема приложения зарегистрирована в контексте и доступна во всем дереве приложения
      ),
      subtitle: Text("${coin.priceInUSD}\$",
          style: theme.textTheme.labelSmall
      ),
    );
  }
}