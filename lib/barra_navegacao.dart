// barra_navegacao.dart
// Barra de navegação inferior, usada nas telas Início, Buscar e Pedidos.

import 'package:flutter/material.dart';

import 'busca.dart';
import 'home.dart';
import 'pedidos.dart';

class BarraNavegacao extends StatelessWidget {
  // Índice do item selecionado: 0 = Início, 1 = Buscar,
  // 2 = Pedidos e 3 = Perfil
  final int indice;

  const BarraNavegacao({super.key, required this.indice});

  // Chamada quando o usuário toca em um item da barra
  void trocarTela(BuildContext context, int novoIndice) {
    // Se tocou na tela que já está aberta, não faz nada
    if (novoIndice == indice) return;

    if (novoIndice == 0) {
      // pushReplacement troca a tela atual pela nova
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (novoIndice == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BuscaPage()),
      );
    } else if (novoIndice == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PedidosPage()),
      );
    } else {
      // A tela Perfil ainda não foi criada
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tela disponível em breve')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: indice,
      // Fundo arredondado que aparece atrás do ícone selecionado
      indicatorColor: Colors.deepOrange.shade100,
      backgroundColor: Colors.white,
      // Mostra somente os ícones, como no esboço
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (novoIndice) => trocarTela(context, novoIndice),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
        NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
        NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Pedidos'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );
  }
}
