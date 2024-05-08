import 'package:cint/main.dart';
import 'package:cint/pages/posts/salvos/lista_meus_posts.dart';
import 'package:flutter/material.dart';
import '../pages/posts/salvos/lista_meus_posts.dart';
import '../pages/posts/anuncio_form.dart';

bool isEditing = false;
PostOferta? ofertaEditada;

class PostOferta {
  String produto;
  String quantidade;
  String condicoes;
  String categoria;
  String telefone;
  String info;
  Image icon;
  String textoPrincipal;

  PostOferta(
    this.produto,
    this.quantidade,
    this.condicoes,
    this.categoria,
    this.telefone,
    this.info,
    this.icon,
    this.textoPrincipal,
  );
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
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Row(
        children: [
          Expanded(
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
                      child: widget.oferta.icon,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.oferta.textoPrincipal,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Deletar',
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Deletar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Editar',
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Editar',
                                        style: TextStyle(color: Colors.red),
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
                                      title: Text(
                                        'Detalhes',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                            onSelected: (String value) {
                              if (value == 'Deletar') {
                                setState(() {
                                  widget.deletar();
                                });
                              }
                              if (value == 'Editar') {
                                setState(() {
                                  isEditing = true;
                                  ofertaEditada = widget.oferta;
                                  widget.editar();
                                });
                              }
                              if (value == 'Detalhes') {
                                setState(() {
                                  ofertaEditada = widget.oferta;
                                  widget.detalhes();
                                });
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
