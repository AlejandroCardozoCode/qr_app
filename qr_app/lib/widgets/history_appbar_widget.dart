import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/provider/db_provider.dart';

import '../theme/theme.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onDeleteAll;
  const HistoryAppBar({
    super.key,
    required this.onDeleteAll,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 80,
        backgroundColor: ThemeApp.primary,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: NeumorphicButton(
              onPressed: () {
                onDeleteAll();
              },
              style: NeumorphicStyle(
                color: ThemeApp.primary,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(100),
                ),
              ),
              child: Icon(
                Icons.delete_sweep_outlined,
                color: ThemeApp.secondary,
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: NeumorphicButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: NeumorphicStyle(
              color: ThemeApp.primary,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(100),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ThemeApp.secondary,
            ),
          ),
        ),
        title: Text(
          "History",
          style: GoogleFonts.sora(
            color: ThemeApp.secondary,
            fontWeight: FontWeight.w200,
            letterSpacing: 10,
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);
}
