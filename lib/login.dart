// login.dart
// Projeto Final - Entrega 2: tela de login do app "Sabor Já".
// Apenas interface (sem backend). Qualquer e-mail e senha preenchidos
// corretamente levam para a página inicial.
//
// O formulário segue a receita "Build a form with validation"
// da documentação do Flutter (Form + TextFormField + validator).

import 'package:flutter/material.dart';

import 'home.dart';

// É StatefulWidget porque o botão de "olho" mostra e esconde a senha
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Chave que identifica o formulário. Ela é usada para validar os campos.
  final _formKey = GlobalKey<FormState>();

  bool esconderSenha = true; // a senha começa escondida

  // Mostra uma mensagem rápida na parte de baixo da tela
  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
  }

  // Chamada quando o usuário toca em "Entrar"
  void entrar() {
    // validate() roda o validator de cada campo.
    // Se algum devolver um texto de erro, o resultado é false.
    if (_formKey.currentState!.validate()) {
      // pushReplacement troca o login pela página inicial,
      // assim o botão "voltar" não retorna para o login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Center + SingleChildScrollView: o conteúdo fica no meio
        // e dá para rolar quando o teclado aparece
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // largura toda
                children: [
                  // ===== 1. MARCA =====
                  Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: corPrincipal,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.delivery_dining,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sabor Já',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: corPrincipal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ===== 2. TÍTULO =====
                  const Text(
                    'Entrar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Acesse sua conta para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // ===== 3. CAMPO DE E-MAIL =====
                  const Text(
                    'E-mail',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    // initialValue deixa o campo já preenchido com um exemplo,
                    // assim dá para entrar direto só tocando em "Entrar"
                    initialValue: 'bianca@saborja.com',
                    keyboardType: TextInputType.emailAddress, // teclado com @
                    decoration: estiloCampo('Digite seu e-mail', Icons.email),
                    // validator devolve um texto de erro ou null (tudo certo)
                    validator: (texto) {
                      if (texto == null || texto.isEmpty) {
                        return 'Digite seu e-mail';
                      }
                      if (!texto.contains('@')) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // ===== 4. CAMPO DE SENHA =====
                  const Text(
                    'Senha',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    initialValue: '123456', // senha de exemplo
                    obscureText: esconderSenha, // troca o texto por pontinhos
                    decoration: estiloCampo('Digite sua senha', Icons.lock)
                        .copyWith(
                          // Botão de "olho" para mostrar ou esconder a senha
                          suffixIcon: IconButton(
                            tooltip: esconderSenha
                                ? 'Mostrar senha'
                                : 'Esconder senha',
                            icon: Icon(
                              esconderSenha
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                esconderSenha = !esconderSenha;
                              });
                            },
                          ),
                        ),
                    validator: (texto) {
                      if (texto == null || texto.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                  ),

                  // "Esqueci minha senha" alinhado à direita
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          mostrarMensagem('Enviamos um link para o seu e-mail'),
                      child: const Text('Esqueci minha senha'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ===== 5. BOTÃO ENTRAR =====
                  FilledButton(
                    onPressed: entrar,
                    style: FilledButton.styleFrom(
                      backgroundColor: corPrincipal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ===== 6. DIVISÓRIA "ou" =====
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('ou', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ===== 7. CONTINUAR COM GOOGLE =====
                  OutlinedButton.icon(
                    onPressed: () =>
                        mostrarMensagem('Login com Google disponível em breve'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // Letra "G" colorida no lugar do logo do Google
                    icon: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    label: const Text(
                      'Continuar com Google',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ===== 8. CRIAR CONTA =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem uma conta?',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () =>
                            mostrarMensagem('Cadastro disponível em breve'),
                        child: const Text('Criar conta'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------- WIDGETS AUXILIARES ----------

  // Aparência dos campos de texto (usada no e-mail e na senha)
  InputDecoration estiloCampo(String dica, IconData icone) {
    return InputDecoration(
      hintText: dica,
      prefixIcon: Icon(icone, color: corPrincipal),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // sem linha de borda
      ),
    );
  }
}
