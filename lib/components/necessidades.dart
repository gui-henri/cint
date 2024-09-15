import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Necessidades extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> future;

  const Necessidades({super.key, required this.future});

  @override
  State<Necessidades> createState() => _NecessidadesState();
}

class _NecessidadesState extends State<Necessidades> {
  @override
  Widget build(BuildContext context) {
    final necessidades = widget.future;

    return FutureBuilder(
        future: necessidades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Erro ao carregar necessidades: ${snapshot.error}');
            return const Center(child: Text('Erro ao carregar necessidades.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma necessidade disponível.'));
          }

          List<Map<String, dynamic>> data = snapshot.data!;

          return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.9,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final necessidade = data[index];
                return NecessidadeCard(
                  nome: necessidade['nome'],
                  urgente: necessidade['urgente'],
                  descricao: necessidade['descricao'],
                );
              });
        });
  }
}

class NecessidadeCard extends StatelessWidget {
  final String nome;
  final String descricao;
  final bool urgente;

  const NecessidadeCard({super.key, required this.nome, required this.urgente, required this.descricao});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return NecessidadePopUp(
              nome: nome,
              descricao: descricao,
              urgente: urgente,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: urgente ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (urgente)
              const Positioned(
                  top: -10,
                  right: -10,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.yellow,
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.black,
                      size: 16,
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

class NecessidadePopUp extends StatelessWidget {
  final String nome;
  final String descricao;
  final bool urgente;

  const NecessidadePopUp(
      {super.key,
      required this.nome,
      required this.descricao,
      required this.urgente});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: urgente ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : null,
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: urgente ? const Text(
                      'URGENTE',
                      style: TextStyle(color: Colors.white),
                    ) : const Text(""),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            descricao,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/necessidade_form');
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.volunteer_activism, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
