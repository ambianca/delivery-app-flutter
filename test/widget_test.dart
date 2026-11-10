// widget_test.dart
// Confere se as telas de login, busca e pedidos funcionam.

import 'package:delivery_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Preenche o login e entra no app (usado nos testes das outras telas)
Future<void> fazerLogin(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.enterText(find.byType(TextFormField).at(0), 'bianca@email.com');
  await tester.enterText(find.byType(TextFormField).at(1), '123456');
  await tester.tap(find.widgetWithText(FilledButton, 'Entrar'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Login valida os campos e abre a página inicial', (tester) async {
    await tester.pumpWidget(const MyApp());

    // Tenta entrar com os campos vazios: aparecem os avisos
    await tester.tap(find.widgetWithText(FilledButton, 'Entrar'));
    await tester.pump();
    expect(find.text('Digite seu e-mail'), findsWidgets);
    expect(find.text('Digite sua senha'), findsWidgets);

    // Com e-mail e senha preenchidos, abre a página inicial
    await fazerLogin(tester);
    expect(find.text('O que você deseja pedir?'), findsOneWidget);
  });

  testWidgets('Busca e filtros atualizam os resultados', (tester) async {
    await fazerLogin(tester);

    // Toca no item "Buscar" da barra de navegação
    await tester.tap(find.byTooltip('Buscar'));
    await tester.pumpAndSettle();

    // Sem busca e sem filtro, aparecem todos os produtos
    expect(find.text('6 itens'), findsOneWidget);

    // Pesquisa por uma categoria
    await tester.enterText(find.byType(TextField), 'pizzas');
    await tester.pump();
    expect(find.text('1 item'), findsOneWidget);
    expect(find.text('Pizza Quatro Queijos'), findsOneWidget);

    // Pesquisa por algo que não existe
    await tester.enterText(find.byType(TextField), 'xyz');
    await tester.pump();
    expect(find.text('Nenhum produto encontrado'), findsOneWidget);

    // Limpa a busca e usa o filtro "Próximos"
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.text('Próximos'));
    await tester.pump();
    expect(find.text('3 itens'), findsOneWidget);
  });

  testWidgets('Tela de pedidos mostra as duas abas', (tester) async {
    await fazerLogin(tester);

    // Toca no item "Pedidos" da barra de navegação
    await tester.tap(find.byTooltip('Pedidos'));
    await tester.pumpAndSettle();

    // Aba "Em andamento" aparece primeiro
    expect(find.text('Meus pedidos'), findsOneWidget);
    expect(find.text('Pedido #0001'), findsOneWidget);
    expect(find.text('Acompanhar pedido'), findsWidgets);

    // Troca para a aba "Anteriores"
    await tester.tap(find.text('Anteriores'));
    await tester.pumpAndSettle();
    expect(find.text('Pedido #0000'), findsOneWidget);
    expect(find.text('Pedir novamente'), findsWidgets);
  });
}
