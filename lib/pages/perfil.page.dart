import 'package:cint/components/footer.dart';
import 'package:cint/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cint/main.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  static const routeName = '/perfil';

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Dados do usuário
  String userName = 'Natália Oliveira';
  String userProfileImage =
      'assets/images/perfil.png'; // Caminho da imagem de perfil
  String userTitle =
      'Iniciante Generoso'; // Título que o usuário terá (pode ser mudado)
  String userAvaliation = '5.0'; // Avaliação do usuário (pode ser mudado)

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'];
    List<String> nomes = fullName.split(" ");
    String primeiroNome = nomes.first;
    String ultimoNome = nomes.length > 1 ? nomes.last : "";
    final userName = '$primeiroNome $ultimoNome';
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {},
      ),
      bottomNavigationBar: const Footer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                26.0, 42.0, 35.0, 0), // Espaçamento ajustado
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
                      const SizedBox(
                          height: 0.2), // Espaçamento entre o nome e o título
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
                              const SizedBox(
                                  width:
                                      5), // Espaçamento entre o texto e o ícone
                              Container(
                                width: 30, // Largura do ícone
                                height: 30, // Altura do ícone
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/icone_doador.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          height:
                              0.2), // Espaçamento entre o título e a avaliação
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          const SizedBox(
                              width: 5), // Espaçamento entre o ícone e o número
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
                    if (profileImageUrl != null)
                      ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await supabase.auth.signOut();
              if (context.mounted) {
                Navigator.pushNamed(context, '/');
              }
            },
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), color: Colors.red),
                child: const Text(
                  'Desconectar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
