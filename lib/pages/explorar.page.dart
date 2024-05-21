import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';
import '../components/icones_ong.dart';

List<DadosOng> listaOngs = [
  DadosOng(
      'Mãos Solidárias',
      'A missão da Mãos Solidárias é criar oportunidades e promover o desenvolvimento em comunidades carentes, visando erradicar a pobreza.',
      '../../assets/images/ongImg-1.png',
      'Sem-teto'),
  DadosOng(
    'Esperança Renovada',
    'Nossa ONG está comprometida em defender os direitos das crianças em todas as esferas da vida, seja em questões de saúde, educação, justiça ou igualdade de oportunidades. Trabalhamos em parceria com outras organizações, governos e comunidades para criar um ambiente onde os direitos das crianças sejam respeitados e protegidos.',
    '../../assets/images/ong_generica-2.jpg',
    'Crianças',
  ),
];

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({super.key});

  static const routeName = '/explorar';

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  List<String> ongsFiltradas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header(),
        bottomNavigationBar: const Footer(),
        body: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                botaoFiltrar(),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (ongsFiltradas.isEmpty) {
                    return OngCard(
                      nome: listaOngs[index].nome,
                      descricao: listaOngs[index].descricao,
                      imagem: listaOngs[index].imagem,
                      iconTipo: iconesOng.firstWhere((item) =>
                          item["tipo"] == listaOngs[index].tipo)["icon-white"],
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
                itemCount: listaOngs.length,
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
                  iconOff:
                      '../../assets/icons/educacao-icon/educacao_green.png',
                  iconOn: '../../assets/icons/educacao-icon/educacao_white.png',
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
                  iconOff:
                      '../../assets/icons/criancas-icon/criancas_green.png',
                  iconOn: '../../assets/icons/criancas-icon/criancas_white.png',
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
                  iconOff: '../../assets/icons/idosos-icon/idosos_green.png',
                  iconOn: '../../assets/icons/idosos-icon/idosos_white.png',
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
                  iconOff:
                      '../../assets/icons/sem-teto-icon/sem-teto_green.png',
                  iconOn: '../../assets/icons/sem-teto-icon/sem-teto_white.png',
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
                  iconOff:
                      '../../assets/icons/mulheres-icon/mulheres_green.png',
                  iconOn: '../../assets/icons/mulheres-icon/mulheres_white.png',
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
                  iconOff:
                      '../../assets/icons/religiosas-icon/religiosas_green.png',
                  iconOn:
                      '../../assets/icons/religiosas-icon/religiosas_white.png',
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
                  iconOff:
                      '../../assets/icons/minorias-icon/minorias_green.png',
                  iconOn: '../../assets/icons/minorias-icon/minorias_white.png',
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
                  iconOff:
                      '../../assets/icons/ambientais-icon/ambientais_green.png',
                  iconOn:
                      '../../assets/icons/ambientais-icon/ambientais_white.png',
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
                  iconOff:
                      '../../assets/icons/culturais-icon/culturais_green.png',
                  iconOn:
                      '../../assets/icons/culturais-icon/culturais_white.png',
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
                  iconOff:
                      '../../assets/icons/reabilitacao-icon/reabilitacao_green.png',
                  iconOn:
                      '../../assets/icons/reabilitacao-icon/reabilitacao_white.png',
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
                  iconOff:
                      '../../assets/icons/refugiados-icon/refugiados_green.png',
                  iconOn:
                      '../../assets/icons/refugiados-icon/refugiados_white.png',
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
