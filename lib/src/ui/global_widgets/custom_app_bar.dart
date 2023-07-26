import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/ui/global_widgets/search_delegate.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              showSearch(context: context, delegate: SearchCharacter(ref));
            },
            child: const Icon(Icons.search),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
