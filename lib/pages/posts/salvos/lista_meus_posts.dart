import 'package:flutter/material.dart';
import '../../../components/post_oferta.dart';

List meusPosts = [];
List tempForm = [];

class ListaMeusPosts extends StatefulWidget {
  const ListaMeusPosts({super.key});

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: meusPosts.length,
        itemBuilder: (context, index) {
          
          return Column(
            children: [
              Dismissible(
                
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    meusPosts.removeAt(index);
                  });
                },
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                    ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                    ),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                
                child: PostCard(
                  oferta: meusPosts[index],
                  deletar: () {
                    setState(() {
                      meusPosts.removeAt(index);
                    });
                  },
                  editar: () {
                    Navigator.pushNamed(context, '/anuncio_form',
                        arguments: meusPosts[index]);
                  },
                  detalhes: () {
                    Navigator.pushNamed(context, '/editar_form',
                        arguments: meusPosts[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
