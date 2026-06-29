import 'package:flutter/material.dart';

import './login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final LoginController _controller = LoginController();

  bool _carregando = false;
  bool _mostrarSenha = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _carregando = true;
    });

    try {
      await _controller.login(
        context: context,
        email: _emailController.text,
        senha: _senhaController.text,
      );
    } catch (e) {
      _senhaController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,

        children: [
          Image.asset("assets/images/splash.png", fit: BoxFit.cover),

          Container(
            color: const Color.fromARGB(255, 192, 192, 192).withOpacity(.55),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),

                child: Card(
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "assets/images/logo.png",
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            "Florida",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "O Jogo da Família",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Transforme tarefas em diversão",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),

                          const SizedBox(height: 35),

                          TextFormField(
                            controller: _emailController,

                            enabled: !_carregando,

                            keyboardType: TextInputType.emailAddress,

                            decoration: const InputDecoration(
                              labelText: "E-mail",
                              prefixIcon: Icon(Icons.email),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Informe o e-mail";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller: _senhaController,

                            enabled: !_carregando,

                            obscureText: !_mostrarSenha,

                            decoration: InputDecoration(
                              labelText: "Senha",

                              prefixIcon: const Icon(Icons.lock),

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _mostrarSenha = !_mostrarSenha;
                                  });
                                },

                                icon: Icon(
                                  _mostrarSenha
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Informe a senha";
                              }

                              return null;
                            },

                            onFieldSubmitted: (_) => _login(),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,

                            height: 50,

                            child: ElevatedButton(
                              onPressed: _carregando ? null : _login,

                              child: _carregando
                                  ? const SizedBox(
                                      height: 22,

                                      width: 22,

                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,

                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("ENTRAR"),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "A recuperação de senha será implementada na próxima etapa.",
                                  ),
                                ),
                              );
                            },

                            child: const Text("Esqueci minha senha"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
