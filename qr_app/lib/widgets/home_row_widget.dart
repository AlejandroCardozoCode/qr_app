import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/provider/db_provider.dart';

import '../models/scan_model.dart';
import '../theme/theme.dart';
import 'widget.dart';

class HomeRowWidget extends StatelessWidget {
  const HomeRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Hero(
          tag: "History",
          child: AppButtonWidget(
            icon: Icon(
              (Icons.list_alt),
              color: ThemeApp.secondary,
            ),
            label: 'History',
            function: () async {
              await Future.delayed(const Duration(milliseconds: 150));
              List<ScanModel> historyList = await DbProvider.db.getAllQRs();
              Navigator.pushNamed(context, "history", arguments: historyList);
            },
          ),
        ),
        AppButtonWidget(
          icon: Icon(
            (Icons.add),
            color: ThemeApp.secondary,
          ),
          label: 'Create',
          function: () {
            Future.delayed(const Duration(milliseconds: 150), () async {
              Navigator.pushNamed(context, "create");
            });
          },
        ),
      ],
    );
  }
}
