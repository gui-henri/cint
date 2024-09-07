import 'package:cint/components/post_oferta.dart';
import 'package:cint/objetos/user.dart';
import 'package:cint/pages/posts/minhas_ofertas.dart';
import 'package:cint/repositorys/anuncios.repository.dart';
import 'package:cint/repositorys/user.repository.dart';
import 'package:flutter/material.dart';

class ListaMeusPosts extends StatefulWidget {
  const ListaMeusPosts({super.key});

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  late Future<List<PostOferta>> meusPosts; // Declarado como late

  final AnunciosRepository rep = AnunciosRepository();
  final UserRepository repUser = UserRepository();        
  List postIds = [];

  @override
  void initState() {
    super.initState();
    meusPosts = rep.gerarPosts(); // Inicializado no initState
    print('Entro na lista de posts.');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostOferta>>(
      future: meusPosts, // Usa o Future inicializado no initState
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          postIds.clear();
          repUser.updateUserPosts(postIds);
          return Center(child: semOfertas()); // Exibir um indicador se não houver ofertas
        } else {
          final postsInstancias = snapshot.data!;
{        Usuario().update(posts: postsInstancias);
        postIds.clear();
        for (var post in Usuario().posts) {
          postIds.add(post.id);
        }
        print('tdspsts: $postIds');
        repUser.updateUserPosts(postIds);}
        print('usuario posts: ${Usuario().posts}');
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
                        // Deletar fotos do post
                        for (var foto in postsInstancias[index].fotosPost) {
                          await rep.deleteFoto(foto);
                        }

                        // Deletar o post do banco de dados
                        await rep.deletePost(postsInstancias[index].id);
                        

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
      },
    );
  }
}
