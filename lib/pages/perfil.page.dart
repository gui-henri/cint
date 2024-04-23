import 'package:cint/components/footer.dart';
import 'package:cint/components/header.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  static const routeName = '/perfil';

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Dados do usuário
  String userName = 'Natália Oliveira';
  String userProfileImage = 'assets/images/perfil.png'; // Caminho da imagem de perfil
  String userTitle = 'Iniciante Generoso'; // Título que o usuário terá (pode ser mudado)
  String userAvaliation = '5.0'; // Avaliação do usuário (pode ser mudado)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      bottomNavigationBar: const Footer(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26.0, 42.0, 35.0, 0), // Espaçamento ajustado
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 0.2), // Espaçamento entre o nome e o título
                      Row(
                        children: [
                          const Text(
                            'Título: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                userTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 5), // Espaçamento entre o texto e o ícone
                              Container(
                                width: 30, // Largura do ícone
                                height: 30, // Altura do ícone
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/icone_doador.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 0.2), // Espaçamento entre o título e a avaliação
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(width: 5), // Espaçamento entre o ícone e o número
                          Text(
                            userAvaliation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // Espaçamento entre o nome e a foto de perfil
                CircleAvatar(
                  radius: 44,
                  backgroundImage: AssetImage(userProfileImage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
