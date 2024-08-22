import 'package:flutter/material.dart';
import '../../../repositorys/anuncios.repository.dart';
import '../anuncio_form.dart';
import '../../../components/post_oferta.dart';
import '../nova_oferta.dart';

List meusPosts = [];
List tempForm = [];

class ListaMeusPosts extends StatefulWidget {
  final dadosMeusPosts;
  const ListaMeusPosts({Key? key, required this.dadosMeusPosts}) : super(key: key);

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  final rep = AnunciosRepository();
  /* final <List<Map<String, dynamic>> futurePosts; */
    @override
  void initState() {
    super.initState();
    print('snapshot dos post!!s: ${widget.dadosMeusPosts}');
    /* futurePosts = widget.dadosMeusPosts; */
  }
  @override
  Widget build(BuildContext context) {
/*   Future<Map<String, List<Map<String, dynamic>>>> fetchPostsInfo() async {
    final data = await futurePosts;
    return {
      'futurePosts': data,
    };
  } */
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 30),
        separatorBuilder: (context, index) => SizedBox(
          height: 20,
        ),
        itemCount: widget.dadosMeusPosts.length,
        itemBuilder: (context, index) {
          
          return Column(
            children: [
              Dismissible(
                
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    widget.dadosMeusPosts.removeAt(index);
                  });
                },
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                    ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                    ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                
                child: PostCard(
                  oferta: PostOferta(
                    widget.dadosMeusPosts[index]['nome_produto'], 
                    widget.dadosMeusPosts[index]['quantidade'], 
                    widget.dadosMeusPosts[index]['condicao'], 
                    widget.dadosMeusPosts[index]['categoria'], 
                    widget.dadosMeusPosts[index]['telefone'], 
                    widget.dadosMeusPosts[index]['informacao_relevante'], 
                    widget.dadosMeusPosts[index]['texto_anuncio'], ),
                  deletar: () {
                    setState(() {
                      widget.dadosMeusPosts.removeAt(index);
                    });
                  },
                  editar: () {
                    Navigator.pushNamed(context, '/anuncio_form',
                        arguments: widget.dadosMeusPosts[index]);
                  },
                  detalhes: () {
                    Navigator.pushNamed(context, '/editar_form',
                        arguments: widget.dadosMeusPosts[index]);
                  },
                ),
              ),
            ],
          );
        },
      )
  );
  }
}
