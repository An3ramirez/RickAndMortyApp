import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/models/episode_model.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/custom_app_bar.dart';

class EpisodeDetailPage extends StatelessWidget {
  const EpisodeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Episode episode =
        ModalRoute.of(context)!.settings.arguments as Episode;

    return Scaffold(
      appBar: CustomAppBar(title: episode.name!),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: size.height * 0.15,
              width: double.infinity,
              child: Center(
                  child: Text(
                episode.name!,
                style: const TextStyle(
                    fontSize: 35.0, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Fecha Lanzamiento: ${episode.airDate}'),
            )
          ],
        ),
      ),
    );
  }
}
