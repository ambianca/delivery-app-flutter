// marca.dart
// Marca do app "Sabor Já": ícone de entregador + nome.
// Fica em um arquivo próprio para ser usada em várias telas
// sem precisar repetir o código.

import 'package:flutter/material.dart';

import 'home.dart'; // usa a corPrincipal definida na página inicial

class Marca extends StatelessWidget {
  const Marca({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min, // a linha ocupa só o espaço necessário
      children: [
        // Círculo laranja com o ícone
        CircleAvatar(
          radius: 18,
          backgroundColor: corPrincipal,
          child: Icon(Icons.delivery_dining, color: Colors.white),
        ),
        SizedBox(width: 6),
        Text(
          'Sabor Já',
          style: TextStyle(
            fontSize: 16,
            color: corPrincipal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
