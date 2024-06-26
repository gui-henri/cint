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
    // Tela principal, que recebe os widgets e as páginas 1 2 e 3
    return Scaffold(
      appBar: initialAppBar(),
      body: Stack(children: [
        screenPages(),
        pageTracker(),
        linhaInferior(),
      ]),
    );
  }

  PageView screenPages() {
    return PageView.builder(
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
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
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

  Widget pageTracker() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            telas.length,
            (index) => buildDot(index, context),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(left: 5, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (currentPageIndex == index)
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
    );
  }

  Widget linhaInferior() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Row(
          children: [
            (currentPageIndex != 2) ? botaoPular() : Spacer(),
            if (currentPageIndex == 2) botaoComecar(),
          ],
        ),
      ),
    );
  }

  Padding modelobotaoInferior(String text) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        width: (currentPageIndex != 2) ? 70 : 100,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  botaoPular() {
    return modelobotaoInferior('Pular');
  }

  botaoComecar() {
    return modelobotaoInferior('Começar');
  }
}
