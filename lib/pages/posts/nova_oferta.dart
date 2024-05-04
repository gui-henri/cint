import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cint/routes.dart';
import '../../components/campo_texto.dart';
import '../../components/footer.dart';
import '../../components/header.dart';
import '../../components/title_back.dart';

class NovaOferta extends StatefulWidget {
  const NovaOferta({super.key});

  static const routeName = '/nova_oferta';

  @override
  State<NovaOferta> createState() => _NovaOfertaState();
}

class _NovaOfertaState extends State<NovaOferta> {
  late var selectedIconURL = null;
  late var selectedIcon = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Header(),
        bottomNavigationBar: const Footer(),
        body: Container(
            color: const Color(0xFFF6F4EB),
            child: FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(children: [
                      titleBack(context, 'Nova oferta', '/anuncio_form'),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: const Color(0xFF28730E),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: selectedIcon,
                                        ),
                                      ],
                                    ),
                                    CampoTexto(
                                      '',
                                      false,
                                      keyboard: TextInputType.multiline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Saúde',
                                  icon:
                                      '../../../assets/icons/saude-icon/saude-green.png',
                                  iconSelected:
                                      '../../../assets/icons/saude-icon/saude-white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/saude-icon/saude-green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/saude-icon/saude-green.png',
                                ),
                                const Spacer(),
                                SquareGesture(
                                  name: 'Educação',
                                  icon:
                                      '../../../assets/icons/educacao-icon/educacao_green.png',
                                  iconSelected:
                                      '../../../assets/icons/educacao-icon/educacao_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/educacao-icon/educacao_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/educacao-icon/educacao_green.png',
                                ),
                                const Spacer(),
                                SquareGesture(
                                  name: 'Crianças',
                                  icon:
                                      '../../../assets/icons/criancas-icon/criancas_green.png',
                                  iconSelected:
                                      '../../../assets/icons/criancas-icon/criancas_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/criancas-icon/criancas_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/criancas-icon/criancas_green.png',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Idosos',
                                  icon:
                                      '../../../assets/icons/idosos-icon/idosos_green.png',
                                  iconSelected:
                                      '../../../assets/icons/idosos-icon/idosos_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/idosos-icon/idosos_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/idosos-icon/idosos_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Sem-teto',
                                  icon:
                                      '../../../assets/icons/sem-teto-icon/sem-teto_green.png',
                                  iconSelected:
                                      '../../../assets/icons/sem-teto-icon/sem-teto_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/sem-teto-icon/sem-teto_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/sem-teto-icon/sem-teto_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Mulheres',
                                  icon:
                                      '../../../assets/icons/mulheres-icon/mulheres_green.png',
                                  iconSelected:
                                      '../../../assets/icons/mulheres-icon/mulheres_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/mulheres-icon/mulheres_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/mulheres-icon/mulheres_green.png',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Religiosas',
                                  icon:
                                      '../../../assets/icons/religiosas-icon/religiosas_green.png',
                                  iconSelected:
                                      '../../../assets/icons/religiosas-icon/religiosas_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/religiosas-icon/religiosas_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/religiosas-icon/religiosas_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Minorias',
                                  icon:
                                      '../../../assets/icons/minorias-icon/minorias_green.png',
                                  iconSelected:
                                      '../../../assets/icons/minorias-icon/minorias_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/minorias-icon/minorias_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/minorias-icon/minorias_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Ambientais',
                                  icon:
                                      '../../../assets/icons/ambientais-icon/ambientais_green.png',
                                  iconSelected:
                                      '../../../assets/icons/ambientais-icon/ambientais_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/ambientais-icon/ambientais_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/ambientais-icon/ambientais_green.png',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SquareGesture(
                                  name: 'Culturais',
                                  icon:
                                      '../../../assets/icons/culturais-icon/culturais_green.png',
                                  iconSelected:
                                      '../../../assets/icons/culturais-icon/culturais_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/culturais-icon/culturais_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/culturais-icon/culturais_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Reabilitação',
                                  icon:
                                      '../../../assets/icons/reabilitacao-icon/reabilitacao_green.png',
                                  iconSelected:
                                      '../../../assets/icons/reabilitacao-icon/reabilitacao_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/reabilitacao-icon/reabilitacao_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/reabilitacao-icon/reabilitacao_green.png',
                                ),
                                Spacer(),
                                SquareGesture(
                                  name: 'Refugiados',
                                  icon:
                                      '../../../assets/icons/refugiados-icon/refugiados_green.png',
                                  iconSelected:
                                      '../../../assets/icons/refugiados-icon/refugiados_white.png',
                                  onTap: () {
                                    setState(() {
                                      selectedIconURL =
                                          '../../../assets/icons/refugiados-icon/refugiados_green.png';
                                      selectedIcon =
                                          Image.asset(selectedIconURL);
                                    });
                                  },
                                  isSelected: selectedIconURL ==
                                      '../../../assets/icons/refugiados-icon/refugiados_green.png',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            )));
  }
}

class SquareGesture extends StatelessWidget {
  final String? name;
  final String? icon;
  final String? iconSelected;
  final Function? onTap;
  final bool isSelected;

  const SquareGesture(
      {Key? key,
      this.name,
      this.icon,
      this.onTap,
      required this.isSelected,
      this.iconSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFF28730E),
          ),
          color: isSelected ? const Color(0xFF28730E) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected ? Image.asset(iconSelected!) : Image.asset(icon!),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF28730E)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
