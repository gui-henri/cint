import 'package:flutter/material.dart';
import '../components/header.dart';
import '../components/footer.dart';

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
                    color: Colors.green,
                    child: Text(ongsFiltradas[index]),
                  );
                },
                itemCount: ongsFiltradas.length,
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
              const PopupMenuItem<String>(
                value: 'Editar',
                child: ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Detalhes',
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
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
  final Function? onTap;
  final String tipo;
  final List<String> ongsFiltradas;
  const botaoTipoOng(
      {super.key, this.onTap, required this.tipo, required this.ongsFiltradas});

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
                    '../../assets/icons/saude-icon/saude-white.png',
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    '../../assets/icons/saude-icon/saude-green.png',
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}
