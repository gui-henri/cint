import 'package:cint/main.dart';
import 'package:cint/pages/posts/minhas_ofertas.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  late SupabaseStreamBuilder streamPosts;
  final ListaMinhasOfertas listaMinhasOfertas = ListaMinhasOfertas();
    @override
  void initState() {
    super.initState();
    streamPosts = supabase.from('anuncio').stream(primaryKey: ['id']).eq('user_email', supabase.auth.currentSession?.user.email as Object);
  }
  @override
  Widget build(BuildContext context) {
    print('dadospost ${widget.dadosMeusPosts[0]}');

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: streamPosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ocorreu um erro: ${snapshot.error}'));
        }

        final posts = snapshot.data ?? [];

        if (posts.isEmpty) {
          return Center(child: semOfertas());
        }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          
          return Column(
            children: [
Dismissible(
  key: UniqueKey(),
  onDismissed: (direction) async {
    var i = 0;
    for (var foto in widget.dadosMeusPosts[index].fotosPost) {
      print('foto: $foto');
      rep.deleteFoto(foto);
      print(i);
    }


    // Deleta o post do banco de dados
    await rep.deletePost(widget.dadosMeusPosts[index].id);

    // Atualiza o estado da lista
    setState(() {
      widget.dadosMeusPosts.removeWhere((element) => element['id'] == widget.dadosMeusPosts[index].id);
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
  );}
  );}}

