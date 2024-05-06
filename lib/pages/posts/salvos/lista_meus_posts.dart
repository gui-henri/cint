import 'package:flutter/material.dart';
import '../anuncio_form.dart';
import '../../../components/post_oferta.dart';

List meusPosts = [];

class ListaMeusPosts extends StatefulWidget {
  const ListaMeusPosts({Key? key}) : super(key: key);

  @override
  State<ListaMeusPosts> createState() => _ListaMeusPostsState();
}

class _ListaMeusPostsState extends State<ListaMeusPosts> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 30),
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
      itemCount: meusPosts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostCard(
              oferta: meusPosts[index],
              onPressed: () {
                setState(() {
                  meusPosts.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
