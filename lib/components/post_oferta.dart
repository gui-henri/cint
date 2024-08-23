import 'package:cint/main.dart';
import 'package:flutter/material.dart';

bool isEditing = false;
PostOferta? ofertaEditada;

class PostOferta {
  String produto;
  int quantidade;
  int condicoes;
  int categoria;
  String telefone;
  String info;
  //Image icon;
  String textoPrincipal;
  String id;
  //List fotosPost;
  PostOferta(this.produto, this.quantidade, this.condicoes, this.categoria,
      this.telefone, this.info, this.textoPrincipal, this.id);
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
/*   void _showImageDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: Image.file(
              widget.oferta.fotosPost[index],
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    final profileImageUrl = user?.userMetadata?['avatar_url'];
    final fullName = user?.userMetadata?['full_name'];
    List<String> nomes = fullName.split(" ");
    String primeiroNome = nomes.first;
    String ultimoNome = nomes.length > 1 ? nomes.last : "";
    final userName = '$primeiroNome $ultimoNome';
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
                    /* Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF28730E),
                        ),
                        color: Colors.white,
                      ),
                      child: widget.oferta.icon,
                    ), */
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
                    /* Row(
                      children: [
                        widget.oferta.fotosPost.isNotEmpty
                            ? Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        widget.oferta.fotosPost.map((photo) {
                                      int index = widget.oferta.fotosPost
                                          .indexOf(photo);
                                      return GestureDetector(
                                        onTap: () => _showImageDialog(index),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.file(
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
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ), */
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


class ListaMinhasOfertas {
  List<PostOferta> listaPosts;
  ListaMinhasOfertas(this.listaPosts);

  List<PostOferta> getList() {
    return listaPosts;
  }

  addPost(value) {
    listaPosts.add(value);
  }

  fillList(value) {
    for (var post in value) {
      if (!(listaPosts.contains(post))) {
        listaPosts.add(
          PostOferta(
          post['nome_produto'], 
          post['quantidade'], 
          post['condicao'], 
          post['categoria'], 
          post['telefone'], 
          post['informacao_relevante'], 
          post['texto_anuncio'], 
          post['id']
          )
        );
      }
    }
  }
}