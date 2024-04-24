import 'package:cint/pages/apresentacao/apresentacao1.dart';
import 'package:cint/pages/apresentacao/apresentacao2.dart';
import 'package:cint/pages/apresentacao/apresentacao3.dart';
import 'package:flutter/material.dart';

class ApresentacaoPage extends StatefulWidget {
  const ApresentacaoPage({Key? key}) : super(key: key);

  static const routeName = '/ApresentacaoPage';

  @override
  State<ApresentacaoPage> createState() => _ApresentacaoPageState();
}

class _ApresentacaoPageState extends State<ApresentacaoPage> {
  final List<Widget> telas = const [
    Apresentacao1(),
    Apresentacao2(),
    Apresentacao3(),
  ];
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: initialAppBar(),
      body: PageView.builder(
        controller: _pageController,
        itemCount: telas.length,
        itemBuilder: (_, i) {
          return telas[i];
        },
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }

  Widget forwardButton() {
    if (currentPageIndex != 2) {
      return IconButton(
        onPressed: () {
          _pageController.nextPage(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 300),
          );
        },
        icon: const Icon(Icons.arrow_forward_ios_rounded),
      );
    } else {
      return Container();
    }
  }

  Widget backButton() {
    if (currentPageIndex != 0) {
      return IconButton(
        onPressed: () {
          _pageController.previousPage(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 300),
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      );
    } else {
      return Container();
    }
  }

  initialAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      actions: [
        backButton(),
        const Spacer(),
        forwardButton(),
      ],
      actionsIconTheme: const IconThemeData(
        color: Color(0xFF28730E),
      ),
    );
  }
}
