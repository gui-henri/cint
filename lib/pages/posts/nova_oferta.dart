import 'dart:convert';

import 'package:cint/main.dart';
import 'package:cint/objetos/posts.dart';
import 'package:cint/objetos/user.dart';
import 'package:cint/repositorys/user.repository.dart';
import 'package:flutter/material.dart';
import '../../components/campo_texto.dart';
import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/post_oferta.dart';
import '../../components/title_back.dart';
import '../../repositorys/anuncios.repository.dart';
import 'salvos/lista_meus_posts.dart';
import '../../components/icones_ong.dart';


class NovaOferta extends StatefulWidget {
  const NovaOferta({super.key});

  static const routeName = '/nova_oferta';

  @override
  State<NovaOferta> createState() => _NovaOfertaState();
}

class _NovaOfertaState extends State<NovaOferta> {
  late var selectedIconURL = null;
  late var selectedIconImage = null;
  late var selectedIconCategory = null;
  final UserRepository repUser = UserRepository();
  var invalido = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool _hasChanged = false;
  bool _iconChanged = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      if (!_hasChanged && _controller.text.isNotEmpty) {
        setState(() {
          _hasChanged = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('changed: $_hasChanged');
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final postNovo = arguments[2] as PostOferta;
    final fotosPost = arguments[0];
    
    if (isEditing) {
      if (arguments[2]!=null) {
        final postEditado = arguments[2] as PostOferta;
        print(postEditado);
        if (!_hasChanged) {
          _controller.text = postEditado.textoPrincipal;
        } else {print('uaaa');}
      } else {print('nao tem 2');}
    }

    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'];
    List<String> nomes = fullName.split(" ");
    String primeiroNome = nomes.first;
    String ultimoNome = nomes.length > 1 ? nomes.last : "";
    final userName = '$primeiroNome $ultimoNome';
    //final List<PostOferta> postsInstancias = ListaMinhasOfertas();

    final linhaPost = supabase.from('anuncio').stream(primaryKey: ['id']).eq('id', arguments[1]);
    // Define a lista de categorias
    final categories = [
      'Crianças',
      'Reciclagem',
      'Animais',
      'Educação',
      'Idosos',
      'Reabilitação',
      'Culturais',
      'Minorias',
      'Mulheres',
      'Refugiados',
      'Religiosas',
      'Saúde',
      'Sem-teto',
    ];

    return Scaffold(
        appBar: Header(
          atualizarBusca: (value) {},
        ),
        bottomNavigationBar: const Footer(),
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: () async {
              final rep = AnunciosRepository();
              setState(() {
                invalido = (_formKey.currentState!.validate());
              });
              
              print('arguments: $arguments');
              print('texto: ${_controller.text}');
              print('está editando: $isEditing');
              (_formKey.currentState!.validate());
              if (selectedIconCategory != null && _formKey.currentState!.validate()) {
                if (isEditing == false) {
                  setState(() {
                    postNovo.textoPrincipal = _controller.text;
                    postNovo.icon = categories.indexOf(selectedIconCategory)+1;
                    postNovo.usuario = Usuario().id;
                  });
                  
                  

                  print('postNovo: ${postNovo.usuario}');
                  print('usuario nome: ${Usuario().nome}');
                  await rep.criarPost(postNovo.toJson());
/*                   final posts = await rep.gerarPosts();
                  repUser.sendPosts(posts); */
                  

                }
                if (isEditing) {
                  setState(() {
                    postNovo.textoPrincipal = _controller.text;
                    postNovo.icon = categories.indexOf(selectedIconCategory)+1;
                  });
                  await rep.updatePost(
                    postNovo.id,
                    postNovo
                    );
/*                   await rep.updatePost(
                    postNovo.id,
                    postNovo.produto, 
                    postNovo.quantidade, 
                    postNovo.condicoes, 
                    postNovo.categoria, 
                    postNovo.telefone, 
                    postNovo.info, 
                    postNovo.textoPrincipal,
                    postNovo.icon,
                    postNovo.fotosPost); */
                }

                Navigator.pushNamed(context, '/minhasofertas', arguments: [postNovo, selectedIconCategory]);
              } else {
                if (selectedIconImage == null) {
                  Future.delayed(const Duration(seconds: 1), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        content: Text(
                          'Selecione um tipo de instituição!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  });
                }
              }
            },
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF6EB855),
            shape: const CircleBorder(),
            child: const Icon(Icons.send),
          ),
        ),
        body: Container(
            color: const Color(0xFFF6F4EB),
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 100.0),
                child: Stack(
                  children: [
                    Column(children: [
                      titleBack(context, 'Nova oferta', '/anuncio_form', [true, arguments[1], (arguments[2] !=null) ? arguments[2] as PostOferta : null]),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF28730E),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        if (profileImageUrl != null)
                                          ClipOval(
                                            child: Image.network(
                                              profileImageUrl,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        const SizedBox(width: 8),
                                        Text(
                                          userName ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: const Color(0xFF28730E),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: selectedIconImage
                                        ),
                                      ],
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: CampoTexto('', true, _controller,
                                          keyboard: TextInputType.multiline),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return SquareGesture(
                              name: category,
                              icon: iconesOng.firstWhere(
                                  (item) => item["tipo"] == category)["icon-green"],
                              iconSelected: iconesOng.firstWhere(
                                  (item) => item["tipo"] == category)["icon-white"],
                              onTap: () {
                                setState(() {
                                  selectedIconURL = iconesOng.firstWhere(
                                      (item) => item["tipo"] == category)["icon-green"];
                                  selectedIconCategory = category;
                                  selectedIconImage = Image.asset(selectedIconURL);
                                });
                              },
                              isSelected: 
                              selectedIconURL ==
                                  iconesOng.firstWhere(
                                      (item) => item["tipo"] == category)["icon-green"],
                              invalido: invalido,
                            );
                          },
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            )));
  }
}

class SquareGesture extends StatelessWidget {
  final String? name;
  final String? icon;
  final String? iconSelected;
  final Function? onTap;
  final bool isSelected;
  final bool invalido;

  const SquareGesture({super.key, 
    this.name,
    this.icon,
    this.onTap,
    required this.isSelected,
    this.iconSelected,
    required this.invalido,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: invalido ? Colors.red : const Color(0xFF28730E),
          ),
          color: isSelected ? const Color(0xFF28730E) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isSelected
                  ? Image.asset(iconSelected!)
                  : Image.asset(icon!),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF28730E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
