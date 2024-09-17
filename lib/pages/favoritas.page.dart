import 'package:cint/objetos/instituicao.dart';
import 'package:cint/objetos/user.dart';
import 'package:cint/pages/ong.page.dart';
import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';
import '../components/icones_ong.dart';
import 'package:cint/repositorys/ong.repository.dart';

import '../repositorys/user.repository.dart';

class FavoritasPage extends StatefulWidget {

  const FavoritasPage({super.key});

  static const routeName = '/favoritas';

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  List<String> ongsFiltradas = [];
  late String textoPesquisado = '';
  late String digitando = '';

  late Future<List<Map<String, dynamic>>> futureCategorias;
  List<Instituicao> ongsInstancias = Usuario().favoritas;

  @override
  void initState() {
    super.initState();
    futureCategorias = OngRepository().getCategoria();
  }


  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    Future<Map<String, List<Map<String, dynamic>>>> fetchData() async {
      final data1 = await futureCategorias;
      return {
        'futureCategorias': data1,
      };
    }

    var args = ModalRoute.of(context)?.settings.arguments;
    String argsText = args != null ? args.toString() : '';
    if (digitando != '') {
      argsText = '';
    }
    setState(() {
      if (argsText != '') {
        print('args: $argsText');
        digitando = argsText;
      }
    });

    return Scaffold(
      appBar: Header(
        telaPesquisada: '/favoritas',
        showTextField: true,
        textoSalvo: digitando,
        atualizarBusca: (value) {
          textoPesquisado = value;
          setState(() {
            digitando = value;
          });
        },
      ),
      bottomNavigationBar: const Footer(),
      body: Column(
        children: [
          Row(children: [
            titleFavoritas(),
            const Spacer(),
            botaoFiltrar(),
          ]),
          Expanded(
            child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar categorias'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma categoria encontrada'));
                } else if (Usuario().favoritas.isEmpty){
                  return nenhumaFavorita();
                }

                final categoriasSnapshot = snapshot.data!['futureCategorias']!;
                
                // Cria um mapa para acesso rápido às categorias das ONGs
                final categoriaMap = {
                  for (var categoria in categoriasSnapshot)
                    categoria['id']: categoria['nome']
                };

                // Filtra as ONGs com base nas categorias
                final filteredSnapshot = ongsInstancias.where((ong) {
                  final categoriaNome = categoriaMap[ong.idCategoria];
                  return ongsFiltradas.isEmpty || ongsFiltradas.contains(categoriaNome);
                }).toList();

                // Pesquisa por texto
                final searchSnapshot = ongsInstancias.where((ong) {
                  return digitando.isNotEmpty && ong.nome.toLowerCase().contains(digitando.toLowerCase());
                }).toList();

                // Pesquisa por texto e filtro
                final searchandfilterSnapshot = ongsInstancias.where((ong) {
                  final categoriaNome = categoriaMap[ong.idCategoria];
                  return digitando.isNotEmpty &&
                         ong.nome.toLowerCase().contains(digitando.toLowerCase()) &&
                         ongsFiltradas.contains(categoriaNome);
                }).toList();

/*                 if ((ongsFiltradas.isNotEmpty) && searchandfilterSnapshot.isEmpty) {
                  return Center(
                    child: Text('aaaaaaaa'),
                  );
                }
                else */ if (ongsFiltradas.isNotEmpty && digitando.isEmpty) {
                  return filteredSnapshot.isEmpty ?
                  buscaVazia() :
                  ListView.builder(
                    itemCount: filteredSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = filteredSnapshot[index];
                      final categoriaNome = categoriaMap[ong.idCategoria];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          setState(() {
                            Usuario().favoritas.removeWhere((item) => item.id == ong.id);// Remove a ONG da lista e atualiza a tela
                          });
                          var user = Usuario().toJson();
                          await userRepository.updateUserFavoritas(user['favoritas']);
                          

                        },
                      child: OngCard(
                        id: ong.id,
                        nome: ong.nome,
                        descricao: ong.descricao,
                        imagem: ong.foto,
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      ));
                    },
                  );
                } else if (digitando.isNotEmpty && ongsFiltradas.isEmpty) {
                  if (searchSnapshot.isNotEmpty)
                  {  return ListView.builder(
                      itemCount: searchSnapshot.length,
                      itemBuilder: (context, index) {
                        final ong = searchSnapshot[index];
                        final categoriaNome = categoriaMap[ong.idCategoria];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          setState(() {
                            Usuario().favoritas.removeWhere((item) => item.id == ong.id);// Remove a ONG da lista e atualiza a tela
                          });
                          var user = Usuario().toJson();
                          await userRepository.updateUserFavoritas(user['favoritas']);
                          

                        },
                        child: OngCard(
                          id: ong.id,
                          nome: ong.nome,
                          descricao: ong.descricao,
                          imagem: ong.foto,
                          iconTipo: iconesOng.firstWhere(
                            (item) => item["tipo"] == categoriaNome
                          )['icon-white'],
                        ));
                      },
                    );
                    } else {
                    return Center(
                      child: buscaVazia(),
                    );
                  }
                } else if (digitando.isNotEmpty && ongsFiltradas.isNotEmpty) {
                  return ListView.builder(
                    itemCount: searchandfilterSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = searchandfilterSnapshot[index];
                      final categoriaNome = categoriaMap[ong.idCategoria];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          setState(() {
                            Usuario().favoritas.removeWhere((item) => item.id == ong.id);// Remove a ONG da lista e atualiza a tela
                          });
                          var user = Usuario().toJson();
                          await userRepository.updateUserFavoritas(user['favoritas']);
                          

                        },
                      child: OngCard(
                        id: ong.id,
                        nome: ong.nome,
                        descricao: ong.descricao,
                        imagem: ong.foto,
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      ),
                      );
                    },
                  );
                } else {
                  return Usuario().favoritas.isEmpty ?
                  nenhumaFavorita() :
                  ListView.builder(
                    itemCount: ongsInstancias.length,
                    itemBuilder: (context, index) {
                      final ong = ongsInstancias[index];
                      final categoriaNome = categoriaMap[ong.idCategoria];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          setState(() {
                            Usuario().favoritas.removeWhere((item) => item.id == ong.id);// Remove a ONG da lista e atualiza a tela
                          });
                          var user = Usuario().toJson();
                          await userRepository.updateUserFavoritas(user['favoritas']);
                          

                        },
                        child: OngCard(
                          nome: ong.nome,
                          descricao: ong.descricao,
                          imagem: ong.foto,
                          id: ong.id,
                          iconTipo: iconesOng.firstWhere(
                            (item) => item["tipo"] == categoriaNome
                          )['icon-white'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown de tipos de ONG do botão de filtro
  Widget botaoFiltrar() {
    return PopupMenuButton<String>(
        surfaceTintColor: Colors.white,
        icon: const Icon(Icons.filter_list_outlined),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Animais',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Animais')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Animais')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Animais',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Saúde',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Saúde')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Saúde')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Saúde',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Educação',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Educação')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Educação')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Educação',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Crianças',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Crianças')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Crianças')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Crianças',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Idosos',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Idosos')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Idosos')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Idosos',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Sem-teto',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Sem-teto')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Sem-teto')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Sem-teto',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Mulheres',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Mulheres')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Mulheres')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Mulheres',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Religiosas',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Religiosas')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Religiosas')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Religiosas',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Minorias',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Minorias')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Minorias')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Minorias',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Reciclagem',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Reciclagem')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Reciclagem')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Reciclagem',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Culturais',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Culturais')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Culturais')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Culturais',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Reabilitação',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Reabilitação')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Reabilitação')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Reabilitação',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
              PopupMenuItem<String>(
                value: 'Refugiados',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Refugiados')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Refugiados')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Refugiados',
                  onTap: (tipo) {
                    if (!ongsFiltradas.contains(tipo)) {
                      setState(() {
                        ongsFiltradas.add(tipo);
                      });
                    } else {
                      setState(() {
                        ongsFiltradas.remove(tipo);
                      });
                    }
                  },
                ),
              ),
            ],
          );
  }
}

// Classe Stateful que define o funcionamento dos botões do Dropdown do filtro
class BotaoTipoOng extends StatefulWidget {
  final String iconOn;
  final String iconOff;
  final Function? onTap;
  final String tipo;
  final List<String> ongsFiltradas;
  const BotaoTipoOng(
      {super.key,
      this.onTap,
      required this.tipo,
      required this.ongsFiltradas,
      required this.iconOn,
      required this.iconOff});

  @override
  State<BotaoTipoOng> createState() => _BotaoTipoOngState();
}

class _BotaoTipoOngState extends State<BotaoTipoOng> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.ongsFiltradas.contains(
        widget.tipo); // Verifica se o tipo está na lista ongsFiltradas
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap;
        widget.onTap?.call(widget.tipo);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          textColor: !isSelected ? const Color(0xFF28730E) : Colors.white,
          tileColor: isSelected ? const Color(0xFF28730E) : Colors.white,
          title: Text(widget.tipo),
          leading: Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSelected ? const Color(0xFF28730E) : Colors.white,
            ),
            child: isSelected
                ? Image.asset(
                    widget.iconOn,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    widget.iconOff,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}

class OngCard extends StatefulWidget {
  final String nome;
  final String descricao;
  final String imagem;
  final String iconTipo;
  final String id;
  const OngCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.iconTipo,
    required this.id,
  });

  @override
  State<OngCard> createState() => _OngCardState();
}

class _OngCardState extends State<OngCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6EB855),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/ong', arguments: OngArguments(ongId: widget.id));
        },
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imagem),
                      fit: BoxFit.cover,
                      )
                  ),
                )
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        widget.nome,
                        style: const TextStyle(
                          color: Color(0xFF28730E),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      widget.descricao,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      widget.iconTipo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget titleFavoritas() {
  return const Padding(
    padding: EdgeInsets.all(15.0),
    child: Row(
      children: [
        Icon(Icons.favorite_border, color: Color(0xFF28730E), size: 40,),
        SizedBox(width: 5,),
        Text(
          'Favoritas',
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget buscaVazia() {
  return const Padding(
    padding: EdgeInsets.all(30),
    child: Column(
      children: [
        Text(
          'Sem resultados...',
          style: TextStyle(
            color: Color(0xFF28730E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Você ainda não favoritou nenhuma instituição que corresponda a essa pesquisa!',
          style: TextStyle(color: Color(0xFF28730E)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget nenhumaFavorita() {
  return const Padding(
    padding: EdgeInsets.all(30),
    child: Column(
      children: [
        Icon(Icons.heart_broken, color: Color.fromARGB(172, 110, 184, 85), size: 100,),
        Text(
          'Nada aqui...',
          style: TextStyle(
            color: Color(0xFF28730E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        Text(
          'Favorite instituições e as veja nessa página!',
          style: TextStyle(color: Color(0xFF28730E)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}