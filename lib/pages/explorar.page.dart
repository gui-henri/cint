import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';
import '../components/icones_ong.dart';
import 'package:cint/repositorys/ong.repository.dart';

class ExplorarPage extends StatefulWidget {

  const ExplorarPage({super.key});

  static const routeName = '/explorar';

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  List<String> ongsFiltradas = [];
  late String textoPesquisado = '';
  late String digitando = '';

    final rep = OngRepository(); 
    late Future<List<Map<String, dynamic>>> futureOngs;
    late Future<List<Map<String, dynamic>>> futureCategorias;


  @override
  void initState() {
    super.initState();
    futureOngs = rep.getAllWithPhotos();
    futureCategorias = rep.getCategoria();

  }

  @override
  Widget build(BuildContext context) {
  Future<Map<String, List<Map<String, dynamic>>>> fetchBothData() async {
    final data1 = await futureOngs;
    final data2 = await futureCategorias;
    return {
      'futureOngs': data1,
      'futureCategorias': data2,
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
              titleExplorar(),
              Image.asset('assets/icons/icon-explore.png'),
              const Spacer(),
              botaoFiltrar(),
            ]),
            Expanded(
              child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
                future: fetchBothData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar ONGs'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhuma ONG encontrada'));
                  }
                  final data = snapshot.data!;
                  final ongsSnapshot = data['futureOngs']!;
                  final categoriasSnapshot = data['futureCategorias']!;

                  // Cria um mapa para acesso rápido às categorias das ONGs
                  final categoriaMap = {
                    for (var categoria in categoriasSnapshot)
                      categoria['id']: categoria['nome']
                  };
                  // Cria um mapa para acesso rápido aos nomes das ONGs
                  final ongNomeMap = {
                    for (var ong in ongsSnapshot)
                      ong['id']: ong['nome']
                  };

                  // Filtra as ONGs com base nas categorias
                  final filteredSnapshot = ongsSnapshot.where((ong) {
                    final categoriaNome = categoriaMap[ong['id_categoria']];
                    return ongsFiltradas.isEmpty || ongsFiltradas.contains(categoriaNome);
                  }).toList();

                  // Pesquisa por texto
                  final searchSnapshot = ongsSnapshot.where((ong) {
                    final ongNome = ongNomeMap[ong['id']];
                    return digitando.isNotEmpty && ongNome.toLowerCase().contains(digitando.toLowerCase());
                  }).toList();

                  // Pesquisa por texto e filtro
                  final searchandfilterSnapshot = ongsSnapshot.where((ong) {
                    final categoriaNome = categoriaMap[ong['id_categoria']];
                    final ongNome = ongNomeMap[ong['id']];
                    return digitando.isNotEmpty && ongNome.toLowerCase().contains(digitando.toLowerCase()) && ongsFiltradas.contains(categoriaNome);
                  }).toList();

                  // se apenas estiver filtrando, retorna uma listview com
                  // as ongs filtradas
                  if (ongsFiltradas.isNotEmpty && digitando.isEmpty)
                  {
                    return ListView.builder(
                    itemCount: filteredSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = filteredSnapshot[index];
                      final categoriaNome = categoriaMap[ong['id_categoria']];
                      return OngCard(
                        nome: ong['nome'],
                        descricao: ong['descricao'],
                        imagem: ong['foto_instituicao'][0]['url'],
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      );
                    },
                  );} else {
                  // se apenas estiver pesquisando por texto, retorna uma listview com
                  // as ongs as quais o nome contem o que foi digitado/pesquisado
                    if (digitando.isNotEmpty && ongsFiltradas.isEmpty) {
                      print(digitando);
                    return ListView.builder(
                    itemCount: searchSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = searchSnapshot[index];
                      final categoriaNome = categoriaMap[ong['id_categoria']];
                      final ongNome = ongNomeMap[ong['id']];
                      return OngCard(
                        nome: ongNome,
                        descricao: ong['descricao'],
                        imagem: ong['foto_instituicao'][0]['url'],
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      );
                    },
                  ); } else
                  // se estiver filtrando e pesquisando por texto ao mesmo tempo,
                  // retorna uma listview com as ongs que estao no filtro por tipo
                  // e que o nome contem o que foi digitado/pesquisado
                  {if (digitando.isNotEmpty && ongsFiltradas.isNotEmpty) {
              return ListView.builder(
                    itemCount: searchandfilterSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = searchandfilterSnapshot[index];
                      final categoriaNome = categoriaMap[ong['id_categoria']];
                      final ongNome = ongNomeMap[ong['id']];
                      return OngCard(
                        nome: ongNome,
                        descricao: ong['descricao'],
                        imagem: ong['foto_instituicao'][0]['url'],
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      );
                    },
                  );
                  }
                  else {
                    return ListView.builder(
                    itemCount: ongsSnapshot.length,
                    itemBuilder: (context, index) {
                      final ong = ongsSnapshot[index];
                      final categoriaNome = categoriaMap[ong['id_categoria']];
                      final ongNome = ongNomeMap[ong['id']];
                      return OngCard(
                        nome: ongNome,
                        descricao: ong['descricao'],
                        imagem: ong['foto_instituicao'][0]['url'],
                        iconTipo: iconesOng.firstWhere(
                          (item) => item["tipo"] == categoriaNome
                        )['icon-white'],
                      );
                    },
                  );
                  }
                      
                  }
                  } }
                 /**//*if (digitando.isNotEmpty) {
                    print(digitando);
                    var ongs = ongsSnapshot.toList().where((ong) => ong['nome'].toString().toLowerCase().contains(digitando.toLowerCase()));
                    return (ongs.length > 0) ?
                    ListView(
                      children: ongs
                      .map((ong) {
                        return OngCard(
                        nome: ong['nome'],
                        descricao: 'blablabla',
                        imagem: ong['foto_instituicao'][0]['url'],
                        iconTipo: iconesOng.firstWhere((item) =>
                        item["tipo"] == 'Saúde')['icon-white'],
                        )
                      ;}).toList()
                    ) :
                    const Center(
                      child: Text(
                        'Nenhuma ONG correspondente à pesquisa',
                        style: TextStyle(color: Color(0xFF28730E)),
                        textAlign: TextAlign.center,                        
                        ),
                    );
                 }  */
                  
  ),
            ),
          ],
        ));
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
  const OngCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.iconTipo,
  });

  @override
  State<OngCard> createState() => _OngCardState();
}

class _OngCardState extends State<OngCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6EB855),
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
    );
  }
}

Widget titleExplorar() {
  return const Padding(
    padding: EdgeInsets.all(15.0),
    child: Row(
      children: [
        Text(
          'Instituições',
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
