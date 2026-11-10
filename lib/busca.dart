// busca.dart
// Projeto Final - Entrega 3: tela de listagem e pesquisa do app "Sabor Já".
// Apenas interface (sem backend). Os dados são fictícios.

import 'package:flutter/material.dart';

import 'barra_navegacao.dart';
import 'home.dart'; // usa a corPrincipal definida na página inicial
import 'marca.dart';

// Promoções que aparecem no carrossel
const List<Map<String, String>> promocoes = [
  {
    'titulo': 'Combo em dobro',
    'texto': 'Peça 1 lanche e ganhe outro hoje.',
    'imagem': 'assets/images/combo.jpg',
  },
  {
    'titulo': 'Noite da pizza',
    'texto': '20% de desconto depois das 18h.',
    'imagem': 'assets/images/pizza_calabresa.jpg',
  },
  {
    'titulo': 'Festival japonês',
    'texto': 'Frete grátis em pedidos de sushi.',
    'imagem': 'assets/images/sushi.jpg',
  },
];

// Produtos que aparecem na lista de resultados.
// 'distancia' está em km e 'minutos' é o tempo máximo de entrega.
// Esses números são usados pelos filtros.
const List<Map<String, dynamic>> produtosBusca = [
  {
    'restaurante': 'Burger da Vila',
    'nome': 'X-Bacon Artesanal',
    'categoria': 'Lanches',
    'nota': 4.8,
    'minutos': 40,
    'distancia': 1.5,
    'preco': 'R\$ 32,90',
    'imagem': 'assets/images/hamburguer.jpg',
  },
  {
    'restaurante': 'Pizzaria Bella Massa',
    'nome': 'Pizza Quatro Queijos',
    'categoria': 'Pizzas',
    'nota': 4.7,
    'minutos': 50,
    'distancia': 3.2,
    'preco': 'R\$ 54,00',
    'imagem': 'assets/images/pizza_queijos.jpg',
  },
  {
    'restaurante': 'Verde Vida',
    'nome': 'Salada Colorida',
    'categoria': 'Saudável',
    'nota': 4.9,
    'minutos': 25,
    'distancia': 0.8,
    'preco': 'R\$ 28,50',
    'imagem': 'assets/images/salada.jpg',
  },
  {
    'restaurante': 'Sushi Kento',
    'nome': 'Sushi de Salmão',
    'categoria': 'Japonesa',
    'nota': 4.6,
    'minutos': 45,
    'distancia': 4.0,
    'preco': 'R\$ 46,00',
    'imagem': 'assets/images/sushi.jpg',
  },
  {
    'restaurante': 'Casa Seul',
    'nome': 'Bibimbap',
    'categoria': 'Coreana',
    'nota': 4.8,
    'minutos': 30,
    'distancia': 2.5,
    'preco': 'R\$ 39,90',
    'imagem': 'assets/images/bibimbap.jpg',
  },
  {
    'restaurante': 'Burger da Vila',
    'nome': 'Sanduíche de Frango',
    'categoria': 'Lanches',
    'nota': 4.5,
    'minutos': 30,
    'distancia': 1.5,
    'preco': 'R\$ 29,90',
    'imagem': 'assets/images/sanduiche_frango.jpg',
  },
];

// Nomes dos filtros
const List<String> filtros = [
  'Todos',
  'Próximos',
  'Entrega rápida',
  'Melhor avaliação',
];

// É StatefulWidget porque a lista muda quando o usuário
// digita na busca ou escolhe um filtro
class BuscaPage extends StatefulWidget {
  const BuscaPage({super.key});

  @override
  State<BuscaPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscaPage> {
  String textoBusca = ''; // o que o usuário digitou
  String filtroSelecionado = 'Todos'; // filtro ativo

  // Devolve somente os produtos que combinam com a busca e o filtro
  List<Map<String, dynamic>> buscarProdutos() {
    final List<Map<String, dynamic>> resultado = [];
    // Deixa o texto em minúsculas para "pizza" encontrar "Pizza"
    final String busca = textoBusca.toLowerCase();

    for (final produto in produtosBusca) {
      // Confere se o texto aparece no produto, na categoria ou no restaurante
      final bool combinaComBusca =
          produto['nome'].toLowerCase().contains(busca) ||
          produto['categoria'].toLowerCase().contains(busca) ||
          produto['restaurante'].toLowerCase().contains(busca);

      // Confere a regra do filtro selecionado
      bool combinaComFiltro = true; // "Todos" aceita qualquer produto
      if (filtroSelecionado == 'Próximos') {
        combinaComFiltro = produto['distancia'] <= 2;
      } else if (filtroSelecionado == 'Entrega rápida') {
        combinaComFiltro = produto['minutos'] <= 30;
      } else if (filtroSelecionado == 'Melhor avaliação') {
        combinaComFiltro = produto['nota'] >= 4.8;
      }

      if (combinaComBusca && combinaComFiltro) {
        resultado.add(produto);
      }
    }
    return resultado;
  }

  // Mostra uma mensagem rápida na parte de baixo da tela
  void mostrarMensagem(String mensagem) {
    // Remove a mensagem anterior para não formar uma fila
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    // A lista é calculada de novo sempre que o setState é chamado
    final List<Map<String, dynamic>> resultados = buscarProdutos();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                          'EXPLORAR',
                          style: TextStyle(
                            fontSize: 11,
                            color: corPrincipal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Buscar',
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

              // ===== 2. CAMPO DE BUSCA =====
              campoBusca(),
              const SizedBox(height: 16),

              // ===== 3. CARROSSEL DE PROMOÇÕES =====
              SizedBox(
                height: 140, // o CarouselView precisa de uma altura definida
                child: CarouselView(
                  itemExtent: 280, // largura de cada item
                  itemSnapping: true, // para sempre alinhado em um item
                  // index é a posição do item tocado
                  onTap: (index) {
                    mostrarMensagem(promocoes[index]['titulo']!);
                  },
                  children: [
                    // Cria um banner para cada promoção da lista
                    for (final promocao in promocoes) bannerPromocao(promocao),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ===== 4. FILTROS =====
              const Text(
                'Filtros',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Os filtros ficam todos em uma linha, como no esboço.
              // Se a tela for estreita, a linha rola para o lado
              // em vez de jogar um filtro para baixo.
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final filtro in filtros)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: botaoFiltro(filtro),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ===== 5. RESULTADOS =====
              Row(
                children: [
                  const Text(
                    'Resultados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    // Escreve "item" no singular quando houver apenas um
                    resultados.length == 1
                        ? '1 item'
                        : '${resultados.length} itens',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Se nada foi encontrado, mostra um aviso no lugar da lista
              if (resultados.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('Nenhum produto encontrado'),
                      ],
                    ),
                  ),
                ),

              // Cria um card para cada produto encontrado
              for (final produto in resultados) cardResultado(produto),
            ],
          ),
        ),
      ),

      // ===== 6. BARRA DE NAVEGAÇÃO (1 = Buscar) =====
      bottomNavigationBar: const BarraNavegacao(indice: 1),
    );
  }

  // ---------- WIDGETS AUXILIARES ----------

  // Campo de busca: palavra "Buscar", linha divisória e área de digitação
  Widget campoBusca() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: corPrincipal),
          const SizedBox(width: 4),
          const Text(
            'Buscar',
            style: TextStyle(color: corPrincipal, fontWeight: FontWeight.bold),
          ),
          // Linha vertical que separa a palavra do campo de texto
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey,
          ),
          Expanded(
            child: TextField(
              // onChanged é chamado sempre que o texto muda
              onChanged: (texto) {
                // setState avisa o Flutter para redesenhar a tela
                setState(() {
                  textoBusca = texto;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Produto, categoria ou restaurante',
                hintStyle: TextStyle(fontSize: 13),
                border: InputBorder.none, // a borda já está no Container
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Banner do carrossel: foto ao fundo e textos por cima
  Widget bannerPromocao(Map<String, String> promocao) {
    return Stack(
      fit: StackFit.expand, // faz a foto ocupar todo o banner
      children: [
        Image.asset(promocao['imagem']!, fit: BoxFit.cover),
        // Camada escura para deixar o texto branco mais fácil de ler
        Container(color: Colors.black45),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // textos embaixo
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                promocao['titulo']!,
                // Mantém o texto em uma linha quando o banner fica estreito
                softWrap: false,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                promocao['texto']!,
                softWrap: false,
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Botão de filtro: fica laranja quando está selecionado
  Widget botaoFiltro(String filtro) {
    final bool selecionado = filtro == filtroSelecionado;

    return ChoiceChip(
      label: Text(filtro),
      selected: selecionado,
      showCheckmark: false, // esconde o sinal de "certo"
      selectedColor: corPrincipal,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        fontSize: 12,
        color: selecionado ? Colors.white : Colors.black87,
      ),
      onSelected: (_) {
        setState(() {
          filtroSelecionado = filtro;
        });
      },
    );
  }

  // Card de um produto: foto à esquerda e informações à direita
  Widget cardResultado(Map<String, dynamic> produto) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // ClipRRect arredonda os cantos da foto
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              produto['imagem'],
              width: 100,
              height: 100,
              fit: BoxFit.cover, // preenche o espaço sem deformar a foto
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
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      // Troca o ponto por vírgula: 4.8 vira 4,8
                      '${produto['nota'].toString().replaceAll('.', ',')} • '
                      '${produto['minutos']} min',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
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
                      onPressed: () {
                        mostrarMensagem('${produto['nome']} adicionado');
                      },
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
