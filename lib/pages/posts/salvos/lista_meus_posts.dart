import 'package:flutter/material.dart';
import 'package:cint/objetos/posts.dart';
import 'package:cint/pages/posts/minhas_ofertas.dart';
import 'package:cint/repositorys/anuncios.repository.dart';
import 'package:cint/components/post_oferta.dart';

class ListaMeusPosts extends StatefulWidget {
  const ListaMeusPosts({super.key});

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  final AnunciosRepository rep = AnunciosRepository();
  final List<PostOferta> postsInstancias = ListaMinhasOfertas().anunciosInstancias;

  @override
  void initState() {
    super.initState();
    
    print('entrouuuUU na lista');
  }

  @override
  Widget build(BuildContext context) {
    if (postsInstancias.isEmpty) {
      return Center(child: semOfertas()); // Exibir um indicador de carregamento se a lista estiver vazia
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: postsInstancias.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  await postsInstancias;
                  // Deletar fotos do post
                  for (var foto in postsInstancias[index].fotosPost) {
                    await rep.deleteFoto(foto);
                  }

                  // Deletar o post do banco de dados
                  //await rep.deletePost(postsInstancias[index].id);

                  // Atualizar o estado da lista
                  setState(() {
                    postsInstancias.removeAt(index);
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
                  oferta: postsInstancias[index],
                  deletar: () {
                    setState(() {
                      postsInstancias.removeAt(index);
                    });
                  },
                  editar: () {
                    Navigator.pushNamed(
                      context,
                      '/anuncio_form',
                      arguments: [
                        true,
                        postsInstancias[index].id,
                        postsInstancias[index],
                      ],
                    );
                  },
                  detalhes: () {
                    Navigator.pushNamed(
                      context,
                      '/editar_form',
                      arguments: postsInstancias[index],
                    );
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
