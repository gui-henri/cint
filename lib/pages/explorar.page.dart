import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';

List<DadosOng> listaOngs = [
  DadosOng(
      'Mãos Solidárias',
      'A missão da Mãos Solidárias é criar oportunidades e promover o desenvolvimento em comunidades carentes, visando erradicar a pobreza.',
      'bla')
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
                Spacer(),
                botaoFiltrar(),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: OngCard(nome: listaOngs[index].nome),
                  );
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
                child: botaoTipoOng(
                  iconOff: '../../assets/icons/saude-icon/saude-green.png',
                  iconOn: '../../assets/icons/saude-icon/saude-white.png',
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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
                child: botaoTipoOng(
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

class botaoTipoOng extends StatefulWidget {
  final String iconOn;
  final String iconOff;
  final Function? onTap;
  final String tipo;
  final List<String> ongsFiltradas;
  const botaoTipoOng(
      {super.key,
      this.onTap,
      required this.tipo,
      required this.ongsFiltradas,
      required this.iconOn,
      required this.iconOff});

  @override
  State<botaoTipoOng> createState() => _botaoTipoOngState();
}

class _botaoTipoOngState extends State<botaoTipoOng> {
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    isSelected = widget.ongsFiltradas.contains(
        widget.tipo); // Verifica se o tipo está na lista ongsFiltradas
  }

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
            padding: EdgeInsets.all(5),
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

  DadosOng(this.nome, this.descricao, this.imagem);
}

class OngCard extends StatefulWidget {
  final String nome;
  const OngCard({super.key, required this.nome});

  @override
  State<OngCard> createState() => _OngCardState();
}

class _OngCardState extends State<OngCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [Text(widget.nome)],
      ),
    );
  }
}
