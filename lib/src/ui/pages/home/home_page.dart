import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_drawer_menu.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_message_background.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_list.dart';
import 'package:rick_and_morty_app/src/ui/pages/home/character_state.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();
  final List<String> status = <String>['All', 'Alive', 'Dead', 'Unknown'];
  final List<String> gender = <String>[
    'All',
    'Female',
    'Male',
    'Genderless',
    'Unknown'
  ];
  String statusValue = '';
  String genderValue = '';
  bool isLoadingPage = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    statusValue = status.first;
    genderValue = gender.first;
    final apiProvider = ref.read(characterStateProvider.notifier);
    apiProvider.getCharacters(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        final characterProvider = ref.read(characterStateProvider);
        setState(() {
          isLoadingPage = true;
        });
        if (!characterProvider.hasMoreItems) return;
        page++;
        await apiProvider.getCharacters(
          page,
          stateFilter: statusValue,
          genderFilter: genderValue,
        );
        setState(() {
          isLoadingPage = false;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characterProvider = ref.watch(characterStateProvider);
    final size = MediaQuery.of(context).size;
    final errorApi = characterProvider.error;
    if (errorApi != '') {
      Future.delayed(const Duration(milliseconds: 100), () {
        showError(errorApi);
      });
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'Personajes'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          children: [
            _filterMenu(),
            SizedBox(
              height: size.height * 0.83,
              width: double.infinity,
              child: characterProvider.loader
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : errorApi != ''
                      ? CustomMessageBackground(message: errorApi)
                      : CharacterList(
                          apiProvider: characterProvider,
                          isLoading: isLoadingPage,
                          scrollController: scrollController,
                        ),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawerMenu(),
    );
  }

  Widget _filterMenu() {
    final apiProvider = ref.read(characterStateProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 15),
          child: Text('Status:'),
        ),
        DropdownButton<String>(
          value: statusValue,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            setState(() {
              statusValue = value!;
              page = 1;
              apiProvider.getCharacters(
                page,
                stateFilter: value,
                genderFilter: genderValue,
              );
            });
          },
          items: status.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 15, left: 10),
          child: Text('Gender:'),
        ),
        DropdownButton<String>(
          value: genderValue,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            setState(() {
              genderValue = value!;
              page = 1;
              apiProvider.getCharacters(
                page,
                genderFilter: value,
                stateFilter: statusValue,
              );
            });
          },
          items: gender.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

  showError(String error) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error Inesperado',
      desc: error,
      btnOkOnPress: () {},
    ).show();
  }
}
