import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';
import '../components/icones_ong.dart';

List<DadosOng> listaOngs = [
  DadosOng(
      'Mãos Solidárias',
      'A missão da Mãos Solidárias é criar oportunidades e promover o desenvolvimento em comunidades carentes, visando erradicar a pobreza.',
      'assets/images/ongImg-1.png',
      'Sem-teto'),
  DadosOng(
    'Esperança Renovada',
    'Nossa ONG está comprometida em defender os direitos das crianças em todas as esferas da vida, seja em questões de saúde, educação, justiça ou igualdade de oportunidades. Trabalhamos em parceria com outras organizações, governos e comunidades para criar um ambiente onde os direitos das crianças sejam respeitados e protegidos.',
    'assets/images/ong_generica-2.jpg',
    'Crianças',
  ),
];

class ExplorarPage extends StatefulWidget {
  final List<DadosOng> ongsPesquisadas = [];

  ExplorarPage({super.key, required List<DadosOng> ongsPesquisadas});

  static const routeName = '/explorar';

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  List<String> ongsFiltradas = [];
  late List<DadosOng> ongsEncontradas;
  late String textoPesquisado = '';
  late String digitando = '';

  @override
  initState() {
    ongsEncontradas = listaOngs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // problema: o args fica reconstruindo a lista a partir do texto dele,
    // então a mudança na barra de pequisa não consegue alterar a lista
    // porque o args sempre fica salvo
    var args = ModalRoute.of(context)?.settings.arguments;
    String argsText = args != null ? args.toString() : '';
    if (digitando != '') {
      argsText = '';
    }
    setState(() {
      if (argsText != '') {
        print('args: $argsText');
        ongsEncontradas = listaOngs
            .where((ong) =>
                ong.nome.toLowerCase().contains(argsText.toLowerCase()))
            .toList();
        argsText = '';
      }
    });
    return Scaffold(
        appBar: Header(
          textoSalvo: digitando,
          atualizarBusca: (value) {
            //print('argsText: $argsText');
            print('att');

            textoPesquisado = value;
            setState(() {
              digitando = value;
              //argsText = '';
              if (value.isNotEmpty) {
                print('value: $value');
                ongsEncontradas = listaOngs
                    .where((ong) =>
                        ong.nome.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              } else {
                ongsEncontradas = listaOngs
                    .where((ong) => ong.nome
                        .toLowerCase()
                        .contains(digitando.toLowerCase()))
                    .toList();
              }
            });
          },
        ),
        bottomNavigationBar: const Footer(),
        body: Column(
          children: [
            //Text(textoPesquisado),
            Row(children: [
              titleExplorar(),
              Image.asset('assets/icons/icon-explore.png'),
              const Spacer(),
              botaoFiltrar(),
            ]),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (ongsFiltradas.isEmpty) {
                    return OngCard(
                      nome: ongsEncontradas[index].nome,
                      descricao: ongsEncontradas[index].descricao,
                      imagem: ongsEncontradas[index].imagem,
                      iconTipo: iconesOng.firstWhere((item) =>
                          item["tipo"] ==
                          ongsEncontradas[index].tipo)["icon-white"],
                    );
                  } else {
                    if (ongsFiltradas.contains(listaOngs[index].tipo)) {
                      return OngCard(
                        nome: listaOngs[index].nome,
                        descricao: listaOngs[index].descricao,
                        imagem: listaOngs[index].imagem,
                        iconTipo: iconesOng.firstWhere((item) =>
                            item["tipo"] ==
                            listaOngs[index].tipo)["icon-white"],
                      );
                    }
                  }
                  return const SizedBox();
                },
                itemCount: ongsEncontradas.length,
              ),
            ),
          ],
        ));
  }

  Widget botaoFiltrar() {
    return PopupMenuButton<String>(
        icon: const Icon(Icons.filter_list_outlined),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                value: 'Ambientais',
                child: BotaoTipoOng(
                  iconOff: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Ambientais')["icon-green"],
                  iconOn: iconesOng.firstWhere(
                      (item) => item["tipo"] == 'Ambientais')["icon-white"],
                  ongsFiltradas: ongsFiltradas,
                  tipo: 'Ambientais',
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
        onSelected: (String value) {
          if (value == 'Deletar') {
            setState(() {});
          }
          if (value == 'Editar') {
            setState(() {});
          }
          if (value == 'Detalhes') {
            setState(() {});
          }
        });
  }
}

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

class DadosOng {
  String nome;
  String descricao;
  String imagem;
  String tipo;

  DadosOng(this.nome, this.descricao, this.imagem, this.tipo);
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
              child: Image.asset(
                widget.imagem,
                fit: BoxFit.cover,
              ),
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
