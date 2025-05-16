import 'package:flutter/material.dart';
import 'package:shopping_cart_app/core/theme/app_theme.dart';
import 'package:shopping_cart_app/presentation/views/shopping_list_screen.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart App',
      theme: AppTheme.darkTheme,
      home: const ShoppingListScreen(),
    );
  }
}
