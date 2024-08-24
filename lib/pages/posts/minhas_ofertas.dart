import 'package:flutter/material.dart';
import 'package:cint/routes.dart';
import 'package:flutter/widgets.dart';

import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/title_back.dart';
import '../../main.dart';
import '../../repositorys/anuncios.repository.dart';
import 'anuncio_form.dart';

import '../../components/post_oferta.dart';

import 'salvos/lista_meus_posts.dart';

class MinhasOfertas extends StatefulWidget {
  const MinhasOfertas({super.key});

  static const routeName = '/minhasofertas';

  @override
  State<MinhasOfertas> createState() => _MinhasOfertasState();
}

class _MinhasOfertasState extends State<MinhasOfertas> {
  final rep = AnunciosRepository();
  final Stream<List<Map<String, dynamic>>> futurePosts = supabase.from('anuncio').stream(primaryKey: ['id']).eq('user_email', supabase.auth.currentSession?.user.email as Object);
  final ListaMinhasOfertas listaMinhasOfertas = ListaMinhasOfertas([]);
  @override
  void initState() {
    super.initState();
    /* futurePosts = rep.getPostInfo('user_email', supabase.auth.currentSession?.user.email); */
  }
  @override
  Widget build(BuildContext context) {
/*     var args = ModalRoute.of(context)!.settings.arguments as PostOferta;
    print('os argyumentos: ${args.id}'); */
    return Scaffold(
      appBar: Header(
        atualizarBusca: (value) {},
      ),
      bottomNavigationBar: const Footer(),
      body: Container(
          color: const Color(0xFFF6F4EB),
          child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: futurePosts,
              builder: (context, snapshot) {
                final data = snapshot.data;
                print('snapshot dos posts mO: ${data}');
                if (data!=null) {
/*                   if (args!=null) {
                    listaMinhasOfertas.addPost(args);
                  } */
                  listaMinhasOfertas.fillList(data);
                  print('a lista vaziaaa ${listaMinhasOfertas.getList()}');
                }
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                return Stack(children: [
                  titleBack(context, 'Minhas Ofertas', '/home'),
                  const Center(child: CircularProgressIndicator(color: Color(0xFF28730E),))]);
                } else if (snapshot.hasError) {
                  return Stack(children: [
                    titleBack(context, 'Minhas Ofertas', '/home'),
                    const Center(child: Text('Erro ao carregar ofertas'))]);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty || listaMinhasOfertas.listaPosts.isEmpty || data!.isEmpty) {
                  return Stack(children: [
                    titleBack(context, 'Minhas Ofertas', '/home'),
                    Column(children: [
                          Container(
                            child: semOfertas(),
                            padding: EdgeInsets.only(top: 70),
                          ),
                        ])]);
                }
                          return Stack(children: [
                            titleBack(context, 'Minhas Ofertas', '/home'),
                            Container(
                              padding: const EdgeInsets.only(top: 70),
                              child: ListaMeusPosts(
                                dadosMeusPosts: listaMinhasOfertas.listaPosts
                                ),
                            )
                          ]);
}),),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnuncioForm()),
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF6EB855),
          child: Icon(Icons.add),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}

Widget semOfertas() {
  return const Padding(
    padding: EdgeInsets.all(30),
    child: Column(
      children: [
        Text(
          'Ainda não há ofertas!',
          style: TextStyle(
            color: Color(0xFF28730E),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Para ofertar um produto, é só preencher um formulário. Leva menos de 3 minutos!',
          style: TextStyle(color: Color(0xFF28730E)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
