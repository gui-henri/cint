import 'dart:io';

import 'package:cint/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cint/routes.dart';
import '../../components/campo_texto.dart';
import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/post_oferta.dart';
import '../../components/title_back.dart';
import '../../repositorys/anuncios.repository.dart';
import 'salvos/lista_meus_posts.dart';
import 'anuncio_form.dart';
import '../../components/icones_ong.dart';

class NovaOferta extends StatefulWidget {
  const NovaOferta({super.key});

  static const routeName = '/nova_oferta';

  @override
  State<NovaOferta> createState() => _NovaOfertaState();
}

class _NovaOfertaState extends State<NovaOferta> {
  late var selectedIconURL = null;
  late var selectedIcon = null;
  var invalido = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final fotosPost = arguments[0];
/*     if (isEditing) {
      setState(() {
        //selectedIcon = ofertaEditada!.icon;
        _controller.text = ofertaEditada!.textoPrincipal;
      });
    } */
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
              if (selectedIcon != null && _formKey.currentState!.validate()) {
                if (isEditing == false) {
                setState(() {
                  rep.addTextoAndTipo(arguments[1], _controller.text);
              });
                }
                if (isEditing) {
                  setState(() {
                    //ofertaEditada!.icon = selectedIcon;
                    //ofertaEditada!.textoPrincipal = _controller.text;
                    rep.addTextoAndTipo(arguments[1], _controller.text);
                    isEditing = false;
                  });
                }
                tempForm.clear();
                var novoPostData = await rep.getPostInfo('id', arguments[1]);
                var novoPost = PostOferta(
                  novoPostData[0]['nome_produto'], 
                  novoPostData[0]['quantidade'], 
                  novoPostData[0]['condicao'], 
                  novoPostData[0]['categoria'], 
                  novoPostData[0]['telefone'], 
                  novoPostData[0]['informacao_relevante'], 
                  novoPostData[0]['texto_anuncio'], 
                  novoPostData[0]['id'], 
                  );
                print('novopost: ${novoPost.id}');
                Navigator.pushNamed(context, '/minhasofertas', arguments: novoPost);
              } else {
                if (selectedIcon == null) {
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
            child: Icon(Icons.send),
            shape: CircleBorder(),
          ),
        ),
        body: Container(
            color: const Color(0xFFF6F4EB),
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(children: [
                      titleBack(context, 'Nova oferta', '/anuncio_form', [true, arguments[1]]),
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
                                          child: selectedIcon,
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Saúde',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Saúde')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Saúde')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Saúde')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Saúde')["icon-green"],
                                  invalido: invalido,
                                ),
                                const Spacer(),
                                SquareGesture(
                                  name: 'Educação',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Educação')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Educação')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Educação')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Educação')["icon-green"],
                                  invalido: invalido,
                                ),
                                const Spacer(),
                                SquareGesture(
                                  name: 'Crianças',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Crianças')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Crianças')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Crianças')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Crianças')["icon-green"],
                                  invalido: invalido,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Idosos',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Idosos')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Idosos')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Idosos')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Idosos')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Sem-teto',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Sem-teto')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Sem-teto')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Sem-teto')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Sem-teto')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Mulheres',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Mulheres')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Mulheres')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Mulheres')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Mulheres')["icon-green"],
                                  invalido: invalido,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Religiosas',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Religiosas')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Religiosas')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Religiosas')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Religiosas')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Minorias',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Minorias')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Minorias')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Minorias')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Minorias')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Reciclagem',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reciclagem')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reciclagem')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Reciclagem')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reciclagem')["icon-green"],
                                  invalido: invalido,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Culturais',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Culturais')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Culturais')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Culturais')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Culturais')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Reabilitação',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reabilitação')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reabilitação')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Reabilitação')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Reabilitação')["icon-green"],
                                  invalido: invalido,
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Refugiados',
                                  icon:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Refugiados')["icon-green"],
                                  iconSelected:
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Refugiados')["icon-white"],
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                        iconesOng.firstWhere(
                                          (item) => item["tipo"] == 'Refugiados')["icon-green"];
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                    if (isEditing) {
                                      setState(() {
                                        //ofertaEditada!.icon = selectedIcon;
                                      });
                                    }
                                  },
                                  isSelected: selectedIconURL ==
                                      iconesOng.firstWhere(
                                        (item) => item["tipo"] == 'Refugiados')["icon-green"],
                                  invalido: invalido,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
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

  const SquareGesture({
    Key? key,
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
        width: 100,
        height: 100,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected ? Image.asset(iconSelected!) : Image.asset(icon!),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF28730E)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
