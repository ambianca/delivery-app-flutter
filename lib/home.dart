// home.dart
// Projeto Final - Entrega 1: página inicial do app de delivery "Sabor Já".
// Apenas interface (sem backend). Os dados são fictícios.

import 'package:flutter/material.dart';

import 'barra_navegacao.dart';

// Cor principal do app (identidade visual)
const Color corPrincipal = Colors.deepOrange;

// Dados fictícios dos produtos em destaque.
// Cada produto é um Map com as informações que aparecem no card.
const List<Map<String, dynamic>> produtos = [
  {
    'restaurante': 'Burger da Vila',
    'nome': 'X-Bacon Artesanal',
    'avaliacao': '4,8',
    'tempo': '30-40 min',
    'preco': 'R\$ 32,90',
    'imagem': 'assets/images/hamburguer.jpg',
  },
  {
    'restaurante': 'Pizzaria Bella Massa',
    'nome': 'Pizza de Calabresa',
    'avaliacao': '4,7',
    'tempo': '40-50 min',
    'preco': 'R\$ 49,90',
    'imagem': 'assets/images/pizza_calabresa.jpg',
  },
  {
    'restaurante': 'Verde Vida',
    'nome': 'Salada Colorida',
    'avaliacao': '4,9',
    'tempo': '20-30 min',
    'preco': 'R\$ 28,50',
    'imagem': 'assets/images/salada.jpg',
  },
];

// Tela inicial do app
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // SafeArea evita que o conteúdo fique embaixo da barra de status do celular
      body: SafeArea(
        // SingleChildScrollView permite rolar a tela para baixo
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // alinha tudo à esquerda
            children: [
              // ===== 1. ENDEREÇO + CARRINHO =====
              Row(
                children: [
                  // Expanded: o endereço ocupa o espaço livre e
                  // empurra os botões para a direita
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entregar em',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Rua das Flores, 123',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Alterar')),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text('Carrinho'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ===== 2. SAUDAÇÃO =====
              const Text('Olá, Bianca', style: TextStyle(color: Colors.grey)),
              const Text(
                'O que você deseja pedir?',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // ===== 3. CAMPO DE BUSCA =====
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Digite um produto ou restaurante',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none, // sem linha de borda
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ===== 4. CARD DE PROMOÇÃO (DESTAQUE) =====
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Textos da promoção (Expanded ocupa o espaço que sobrar)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DESTAQUE',
                            style: TextStyle(
                              fontSize: 11,
                              color: corPrincipal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Combo em dobro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Peça 1 lanche e ganhe outro hoje.',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Ver promoção'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Foto da promoção com os cantos arredondados
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/combo.jpg',
                        width: 110,
                        height: 100,
                        fit: BoxFit.cover, // preenche sem deformar a foto
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ===== 5. CATEGORIAS =====
              tituloSecao('Categorias', 'Ver todas'),
              const SizedBox(height: 8),
              Row(
                // distribui as 4 categorias igualmente na linha
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  categoria(Icons.lunch_dining, 'Lanches', selecionada: true),
                  categoria(Icons.local_pizza, 'Pizzas'),
                  categoria(Icons.local_drink, 'Bebidas'),
                  categoria(Icons.cake, 'Doces'),
                ],
              ),
              const SizedBox(height: 20),

              // ===== 6. PRODUTOS EM DESTAQUE =====
              tituloSecao('Produtos em destaque', 'Ver todos'),
              const SizedBox(height: 8),
              // Cria um card para cada produto da lista
              for (final produto in produtos) cardProduto(produto),
            ],
          ),
        ),
      ),

      // ===== 7. BARRA DE NAVEGAÇÃO INFERIOR =====
      // A barra agora fica em um arquivo próprio (0 = Início)
      bottomNavigationBar: const BarraNavegacao(indice: 0),
    );
  }

  // ---------- WIDGETS AUXILIARES ----------
  // Funções que devolvem widgets, para não repetir código.

  // Título de uma seção com o link "Ver todas/Ver todos" à direita
  Widget tituloSecao(String titulo, String link) {
    return Row(
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: Text(link)),
      ],
    );
  }

  // Um item de categoria: quadrado com ícone + nome embaixo
  Widget categoria(IconData icone, String nome, {bool selecionada = false}) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            // a categoria selecionada fica com a cor principal
            color: selecionada ? corPrincipal : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icone,
            size: 32,
            color: selecionada ? Colors.white : corPrincipal,
          ),
        ),
        const SizedBox(height: 4),
        Text(nome, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // Card de um produto: foto à esquerda e informações à direita
  Widget cardProduto(Map<String, dynamic> produto) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Foto do produto (as imagens ficam na pasta assets/images)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              produto['imagem'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Informações do produto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto['restaurante'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  produto['nome'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '⭐ ${produto['avaliacao']} • ${produto['tempo']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      produto['preco'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
