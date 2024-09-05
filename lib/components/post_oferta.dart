import 'dart:async';
import 'dart:convert';

import 'package:cint/components/icones_ong.dart';
import 'package:cint/main.dart';
import 'package:cint/repositorys/ong.repository.dart';
import 'package:flutter/material.dart';
import '../../components/icones_ong.dart';

bool isEditing = false;
PostOferta? ofertaEditada;

class PostOferta {
  String produto;
  int quantidade;
  int condicoes;
  int categoria;
  String telefone;
  String info;
  int icon;
  String textoPrincipal;
  String id;
  List<dynamic> fotosPost;

  PostOferta(
    this.telefone,
    this.info,
    this.id,
    {
    required this.produto,
    required this.quantidade,
    required this.condicoes,
    required this.categoria,
    required this.icon,
    required this.textoPrincipal,
    required this.fotosPost,
  });

  factory PostOferta.fromJson(Map<String, dynamic> json) {
    return PostOferta(
      json['telefone'],
      json['informacao_relevante'],
      json['id'],
      produto: json['nome_produto'],
      quantidade: json['quantidade'],
      condicoes: json['condicao'],
      categoria: json['categoria'],
      icon: json['tipo_id'],
      textoPrincipal: json['texto_anuncio'],
      fotosPost: json['fotos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome_produto': produto,
      'quantidade': quantidade,
      'condicao': condicoes,
      'categoria': categoria,
      'tipo_id': icon,
      'telefone' : telefone,
      'informacao_relevante' : info,
      'texto_anuncio': textoPrincipal,
      'fotos': fotosPost,
    };
  }
}

class PostCard extends StatefulWidget {
  final PostOferta oferta;
  final VoidCallback deletar;
  final VoidCallback editar;
  final VoidCallback detalhes;
  const PostCard({
    super.key,
    required this.oferta,
    required this.deletar,
    required this.editar,
    required this.detalhes,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'];
    List<String> nomes = fullName.split(" ");
    String primeiroNome = nomes.first;
    String ultimoNome = nomes.length > 1 ? nomes.last : "";
    final userName = '$primeiroNome $ultimoNome';
    final preferencia = supabase.from('preferencia').stream(primaryKey: ['id']).eq('id', widget.oferta.icon);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditing = true;
                      ofertaEditada = widget.oferta;
                      widget.editar();
                    });
                  },
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF28730E),
                ),
                color: Colors.white,
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    if (profileImageUrl != null)
                      ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      userName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF28730E),
                        ),
                        color: Colors.white,
                      ),
                      child: StreamBuilder(
                        stream: preferencia, 
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator(color: Color(0xFF28730E),));
                          }
                          return Image.asset(iconesOng.firstWhere(
                                      (item) => item["tipo"] == data![0]['nome'])["icon-green"]);
                      },
                      )
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.oferta.textoPrincipal,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                         Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        widget.oferta.fotosPost.map((photo) {
                                      int index = widget.oferta.fotosPost
                                          .indexOf(photo);
                                      return GestureDetector(
                                        //onTap: () => _showImageDialog(index),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                photo,
                                                height: 200.0,
                                                width: 200.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ),
                              )
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }
}




/* class ListaMinhasOfertas {
  List<PostOferta> _listaPosts = [];
  final _controller = StreamController<List<PostOferta>>.broadcast();

  ListaMinhasOfertas();

  // Getter para o stream
  Stream<List<PostOferta>> get stream => _controller.stream;

  // Getter para a lista de posts
  List<PostOferta> get listaPosts => _listaPosts;


  // Atualiza a lista de posts e notifica os ouvintes
  void fillList(List<Map<String, dynamic>> newPosts) {
    final newPostObjects = newPosts.map((post) => 
    PostOferta(
      post['telefone'],
      post['informacao_relevante'],
      post['id'],
      produto: post['nome_produto'],
      quantidade: post['quantidade'],
      condicoes: post['condicao'],
      categoria: post['categoria'],
      textoPrincipal:  post['texto_anuncio'],
      icon: post['tipo_id'],
      fotosPost: jsonDecode(post['fotos']),
    )).toList();

    // Atualiza a lista interna, adiciona novos posts e remove os deletados
    _listaPosts = _updatePosts(_listaPosts, newPostObjects);

    // Notifica os ouvintes sobre as mudanças
    _controller.sink.add(_listaPosts);
  }

  // Adiciona um post individual e atualiza o stream
  void addPost(PostOferta post) {
    _listaPosts.add(post);
    _controller.sink.add(_listaPosts);
  }

  // Atualiza a lista de posts, removendo posts antigos e adicionando novos
  List<PostOferta> _updatePosts(List<PostOferta> currentPosts, List<PostOferta> newPosts) {
    final existingIds = currentPosts.map((post) => post.id).toSet();
    final updatedPosts = List<PostOferta>.from(currentPosts);

    for (var post in newPosts) {
      if (!existingIds.contains(post.id)) {
        updatedPosts.add(post);
      }
    }

    // Remove posts que não estão mais na lista de novos posts
    updatedPosts.removeWhere((post) => !newPosts.any((newPost) => newPost.id == post.id));
    return updatedPosts;
  }

  // Feche o controller quando não for mais necessário
  void dispose() {
    _controller.close();
  }
} */
