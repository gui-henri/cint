import 'package:cint/main.dart';
import 'package:flutter/material.dart';
import '../../../repositorys/anuncios.repository.dart';
import '../../../components/post_oferta.dart';


List meusPosts = [];
List tempForm = [];

class ListaMeusPosts extends StatefulWidget {
  final dadosMeusPosts;
  const ListaMeusPosts({super.key, required this.dadosMeusPosts});

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  final rep = AnunciosRepository();
  late Future<List<Map<String, dynamic>>> futurePosts;
  final ListaMinhasOfertas listaMinhasOfertas = ListaMinhasOfertas();
    @override
  void initState() {
    super.initState();
    futurePosts = rep.getPostInfo('user_email', supabase.auth.currentSession?.user.email);
  }
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
        itemCount: widget.dadosMeusPosts.length,
        itemBuilder: (context, index) {
          
          return Column(
            children: [
Dismissible(
  key: UniqueKey(),
  onDismissed: (direction) async {
    // Deleta o post do banco de dados
    await rep.deletePost(widget.dadosMeusPosts[index].id);

    // Atualiza o estado da lista
    setState(() {
      widget.dadosMeusPosts.removeAt(index);
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
    oferta: widget.dadosMeusPosts[index],
    deletar: () {
      // Remover do estado local
      setState(() {
        widget.dadosMeusPosts.removeAt(index);
      });
    },
    editar: () {
      Navigator.pushNamed(context, '/anuncio_form',
          arguments: [
            true, 
            widget.dadosMeusPosts[index].id,
            widget.dadosMeusPosts[index],
            ]);
    },
    detalhes: () {
      Navigator.pushNamed(context, '/editar_form',
          arguments: widget.dadosMeusPosts[index]);
    },
  ),
)


            ],
          );
        },
      )
  );
  }
}
