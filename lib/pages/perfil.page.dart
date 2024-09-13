import 'package:cint/components/footer.dart';
import 'package:cint/components/header.dart';
import 'package:cint/objetos/posts.dart';
import 'package:cint/objetos/user.dart';
import 'package:flutter/material.dart';
import 'package:cint/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/components/custom_text_button.dart';

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

  final List<String> preferences = [
    'Orfanatos',
    'Asilos',
    'Creches',
    'Religiosas',
    'Sem-teto',
  ];

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = Usuario().foto;
    final fullName = Usuario().nome;
    List<String> nomes = fullName.split(" ");
    String primeiroNome = nomes.first;
    String ultimoNome = nomes.length > 1 ? nomes.last : "";
    final userName = '$primeiroNome $ultimoNome';
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {}, 
      ),
      bottomNavigationBar: const Footer(),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: ListView( 
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.fromLTRB(26.0, 42.0, 26.0, 0), // Ajuste o padding conforme necessário
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        const SizedBox(height: 8.0), // Espaçamento ajustado
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
                        const SizedBox(height: 8.0), // Espaçamento ajustado
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
                  (profileImageUrl != null) ?
                      ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      )
                  :
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: AssetImage(userProfileImage),
                  ),
                ],
              ),
            

            const SizedBox(height: 10),

            const Divider(
              color: Color.fromARGB(100, 0, 0, 0),
              thickness: 1,
            ),

            // Preferências de Instituições
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextButton(
                    text: 'Preferêcnias de Instituições',
                    onPressed: () => {Navigator.pushReplacementNamed(context, '/apresentacao4')},
                  ),
                  const SizedBox(height: 8.0), // Espaço entre o texto/ícone e a GridView
                  SizedBox(
                    height: 100,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: preferences.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Máximo de 3 por linha
                        crossAxisSpacing: 30.0, // Espaço horizontal entre os itens
                        mainAxisSpacing: 20.0, // Espaço vertical entre os itens
                        childAspectRatio: 3, // Proporção entre largura e altura
                        mainAxisExtent: 40.0, // Altura dos itens
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF28730E),
                            borderRadius: BorderRadius.circular(10.0), // Radius dos botões
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            preferences[index],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              color: Color.fromARGB(100, 0, 0, 0),
              thickness: 1,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 200.0), // Ajuste o padding conforme necessário
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextButton(
                    text: 'Minhas Ofertas',
                    onPressed: () => {Navigator.pushNamed(context, '/minhasofertas')},
                  ),
                  const SizedBox(height: 10),
                  CustomTextButton(
                    text: 'Desempenho',
                    onPressed: () => {Navigator.pushNamed(context, '/Desempenho')},
                  ),
                  // const SizedBox(height: 10),
                  // CustomTextButton(
                  //   text: 'Central de Ajuda',
                  //   onPressed: () => {Navigator.pushNamed(context, '/MetaBatida')},
                  // ),
                  // const SizedBox(height: 10),
                  // CustomTextButton(
                  //   text: 'Envie-nos seu Feedback',
                  //   onPressed: () {
                  //     // Ação ao pressionar o botão
                  //   },
                  // ),
                ],
              ),
            ),

            // Botão de desconectar
            Center(
              child: GestureDetector(
                onTap: () {
                  showLogoutDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFC61C1C)),
                  child: const Text(
                    'Desconectar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
  ]
  )
  )
  );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Você está prestes a desconectar'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da coluna ao conteúdo
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0), // Margem no topo e na parte inferior
              child: Text(
                'Tem certeza?',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal
        ),  
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha a modal
            },
            child: const Text(
              'Voltar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC61C1C), // Cor hexadecimal para o botão 'Desconectar'
            ),
            onPressed: () async {
              // Lógica para desconectar
              await supabase.auth.signOut();
              final GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              if (context.mounted) {
                Navigator.pushNamed(context, '/');
              }
              //ListaMinhasOfertas().anunciosInstancias.clear();
            },
            child: const Text(
              'Desconectar',
              style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
