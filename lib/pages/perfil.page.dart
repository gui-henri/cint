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

  List<String> preferences = [];

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    final user = supabase.auth.currentUser;
    
    if (user != null) {
      final response = await supabase
        .from('usuario_preferencia')
        .select('id_preferencia')
        .eq('id_usuario', user.id);

      if (response.isNotEmpty) {
        // Carregar as preferências
        List<String> loadedPreferences = [];
        
        for (var pref in response) {
          final preferenceData = await supabase
            .from('preferencia')
            .select('nome')
            .eq('id', pref['id_preferencia'])
            .single();

          if (preferenceData['nome'] != null) {
            loadedPreferences.add(preferenceData['nome']);
          }
        }

        setState(() {
          preferences = loadedPreferences;
        });
      }
    }
  }

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
        showTextField: false,
        atualizarBusca: (value) {}, 
      ),
      bottomNavigationBar: const Footer(),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 80.0), // Ajuste o padding inferior para dar espaço ao botão fixo
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(26.0, 42.0, 26.0, 0),
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
                              const SizedBox(height: 8.0),
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
                                      const SizedBox(width: 5),
                                      Container(
                                        width: 30,
                                        height: 30,
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
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
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
                        const SizedBox(width: 10),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextButton(
                            text: 'Preferências de Instituições',
                            onPressed: () => {Navigator.pushReplacementNamed(context, '/preferencias')},
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: preferences.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 30.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 3,
                                mainAxisExtent: 40.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF28730E),
                                    borderRadius: BorderRadius.circular(10.0),
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
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showLogoutDialog(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFC61C1C),
                  ),
                  child: const Text(
                    'Desconectar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
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
              Navigator.of(context).pop();
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
              backgroundColor: const Color(0xFFC61C1C),
            ),
            onPressed: () async {
              await supabase.auth.signOut();
              final GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              if (context.mounted) {
                Navigator.pushNamed(context, '/');
              }
            },
            child: const Text(
              'Desconectar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      );
    },
  );
}
