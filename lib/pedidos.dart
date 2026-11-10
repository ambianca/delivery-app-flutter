// pedidos.dart
// Projeto Final - Entrega 4: tela de pedidos do cliente do app "Sabor Já".
// Apenas interface (sem backend). Os dados são fictícios.
//
// As abas foram feitas com DefaultTabController, TabBar e TabBarView,
// seguindo a receita "Work with tabs" da documentação do Flutter.

import 'package:flutter/material.dart';

import 'barra_navegacao.dart';
import 'home.dart'; // usa a corPrincipal definida na página inicial
import 'marca.dart';

// Pedidos da aba "Em andamento".
// Cada pedido é um Map com as informações que aparecem no card.
// 'itens' é uma lista porque um pedido pode ter vários produtos.
const List<Map<String, dynamic>> pedidosEmAndamento = [
  {
    'numero': '#0001',
    'restaurante': 'Burger da Vila',
    'status': 'Em preparo',
    'itens': ['1x X-Bacon Artesanal', '1x Sanduíche de Frango'],
    'imagem': 'assets/images/hamburguer.jpg',
    'previsao': '19:40',
    'total': 'R\$ 62,80',
  },
  {
    'numero': '#0002',
    'restaurante': 'Sushi Kento',
    'status': 'A caminho',
    'itens': ['2x Sushi de Salmão'],
    'imagem': 'assets/images/sushi.jpg',
    'previsao': '19:55',
    'total': 'R\$ 92,00',
  },
  {
    'numero': '#0003',
    'restaurante': 'Verde Vida',
    'status': 'Confirmado',
    'itens': ['1x Salada Colorida', '1x Suco de Laranja'],
    'imagem': 'assets/images/salada.jpg',
    'previsao': '20:10',
    'total': 'R\$ 38,40',
  },
];

// Pedidos da aba "Anteriores".
// No lugar da previsão de entrega aparece a data do pedido.
const List<Map<String, dynamic>> pedidosAnteriores = [
  {
    'numero': '#0000',
    'restaurante': 'Pizzaria Bella Massa',
    'status': 'Entregue',
    'itens': ['1x Pizza Quatro Queijos', '1x Pizza de Calabresa'],
    'imagem': 'assets/images/pizza_queijos.jpg',
    'data': '05/11/2026',
    'total': 'R\$ 102,00',
  },
  {
    'numero': '#0099',
    'restaurante': 'Casa Seul',
    'status': 'Entregue',
    'itens': ['1x Bibimbap'],
    'imagem': 'assets/images/bibimbap.jpg',
    'data': '01/11/2026',
    'total': 'R\$ 39,90',
  },
  {
    'numero': '#0098',
    'restaurante': 'Burger da Vila',
    'status': 'Cancelado',
    'itens': ['2x Combo em dobro'],
    'imagem': 'assets/images/combo.jpg',
    'data': '28/10/2026',
    'total': 'R\$ 45,80',
  },
];

// Tela de pedidos do cliente
class PedidosPage extends StatelessWidget {
  const PedidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController guarda qual aba está selecionada.
    // length é a quantidade de abas (Em andamento e Anteriores).
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== 1. TÍTULO + MARCA =====
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACOMPANHAMENTO',
                            style: TextStyle(
                              fontSize: 11,
                              color: corPrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Meus pedidos',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Marca(),
                  ],
                ),
                const SizedBox(height: 16),

                // ===== 2. ABAS =====
                abas(),
                const SizedBox(height: 16),

                // ===== 3. CONTEÚDO DAS ABAS =====
                // TabBarView mostra a lista da aba selecionada.
                // Expanded faz ele ocupar o resto da tela.
                Expanded(
                  child: TabBarView(
                    children: [
                      // Aba 1: pedidos em andamento
                      listaPedidos(context, pedidosEmAndamento, true),
                      // Aba 2: pedidos anteriores
                      listaPedidos(context, pedidosAnteriores, false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ===== 4. BARRA DE NAVEGAÇÃO (2 = Pedidos) =====
        bottomNavigationBar: const BarraNavegacao(indice: 2),
      ),
    );
  }

  // ---------- WIDGETS AUXILIARES ----------

  // Abas com fundo cinza e a aba selecionada em laranja,
  // parecido com o esboço
  Widget abas() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        // O indicador vira um "botão" laranja atrás da aba selecionada
        indicator: BoxDecoration(
          color: corPrincipal,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab, // indicador do tamanho da aba
        dividerColor: Colors.transparent, // tira a linha de baixo da TabBar
        labelColor: Colors.white, // texto da aba selecionada
        unselectedLabelColor: Colors.grey, // texto das outras abas
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(
            height: 40,
            icon: Icon(Icons.delivery_dining, size: 18),
            text: 'Em andamento',
            iconMargin: EdgeInsets.zero,
          ),
          Tab(
            height: 40,
            icon: Icon(Icons.history, size: 18),
            text: 'Anteriores',
            iconMargin: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  // Lista de cards de uma aba.
  // emAndamento diz se é a primeira aba (true) ou a segunda (false).
  Widget listaPedidos(
    BuildContext context,
    List<Map<String, dynamic>> pedidos,
    bool emAndamento,
  ) {
    // ListView permite rolar a lista dentro da aba
    return ListView(
      children: [
        for (final pedido in pedidos) cardPedido(context, pedido, emAndamento),
      ],
    );
  }

  // Card de um pedido, montado de cima para baixo como no esboço
  Widget cardPedido(
    BuildContext context,
    Map<String, dynamic> pedido,
    bool emAndamento,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----- Número do pedido + status -----
          Row(
            children: [
              Text(
                'Pedido ${pedido['numero']}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              etiquetaStatus(pedido['status']),
            ],
          ),
          // ----- Nome do restaurante -----
          Text(
            pedido['restaurante'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24), // linha que separa as partes do card
          // ----- Foto + itens do pedido -----
          Row(
            children: [
              // ClipRRect arredonda os cantos da foto
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  pedido['imagem'],
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover, // preenche o espaço sem deformar a foto
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Um texto para cada item do pedido
                    for (final item in pedido['itens'])
                      Text(item, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          // ----- Previsão (ou data) + valor total -----
          Row(
            children: [
              Icon(
                emAndamento ? Icons.schedule : Icons.calendar_today,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                // Em andamento mostra a previsão; anteriores mostra a data
                emAndamento
                    ? 'Previsão: ${pedido['previsao']}'
                    : pedido['data'],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              Text(
                pedido['total'],
                style: const TextStyle(
                  fontSize: 16,
                  color: corPrincipal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ----- Botão do card -----
          // SizedBox com largura infinita deixa o botão da largura do card
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Sem backend, o botão só mostra uma mensagem
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      emAndamento
                          ? 'Pedido ${pedido['numero']}: ${pedido['status']}'
                          : 'Pedido ${pedido['numero']} adicionado ao carrinho',
                    ),
                  ),
                );
              },
              icon: Icon(emAndamento ? Icons.location_on : Icons.replay),
              label: Text(
                emAndamento ? 'Acompanhar pedido' : 'Pedir novamente',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Etiqueta colorida com o status do pedido
  Widget etiquetaStatus(String status) {
    // Escolhe a cor de acordo com o status
    Color cor = corPrincipal; // "Em preparo" fica laranja
    if (status == 'A caminho') {
      cor = Colors.blue;
    } else if (status == 'Confirmado' || status == 'Entregue') {
      cor = Colors.green;
    } else if (status == 'Cancelado') {
      cor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        // withValues deixa a cor transparente (alpha vai de 0 a 1)
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, color: cor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
