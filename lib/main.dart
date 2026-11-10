// main.dart
// Ponto de entrada do app de delivery "Sabor Já".

import 'dart:ui'; // necessário para usar o PointerDeviceKind

import 'package:flutter/material.dart';

import 'login.dart'; // importa a tela de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabor Já', // nome do app
      debugShowCheckedModeBanner: false, // remove a faixa "debug"
      // Permite arrastar o carrossel com o mouse no computador,
      // além do toque no celular
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      // Tema: gera as cores do app a partir da cor principal (laranja)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const LoginPage(), // primeira tela: login
    );
  }
}
