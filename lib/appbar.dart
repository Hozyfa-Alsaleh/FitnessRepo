import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? addOrSend;
  final IconData addSend;
  final void Function()? delete;
  final String title;
  const SharedAppBar(
      {super.key,
      this.delete,
      required this.title,
      this.addOrSend,
      required this.addSend});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 30, color: Colors.black, fontFamily: 'Tajwal'),
      ),
      centerTitle: true,
      leading: delete != null
          ? IconButton(
              onPressed: delete,
              icon: const Icon(
                Icons.delete,
                size: 34,
                color: Colors.black,
              ),
            )
          : null,
      actions: [
        IconButton(
            onPressed: addOrSend,
            icon: Icon(
              addSend,
              size: 34,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
