import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/theme/theme.dart';

import '../provider/db_provider.dart';
import '../widgets/widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ScanModel> historyList = ModalRoute.of(context)!.settings.arguments as List<ScanModel>;

    void _deleteElement(int index) {
      setState(() {
        historyList.removeAt(index);
      });
    }

    void _deleteAll() {
      setState(() {
        historyList.clear();
      });
    }

    return Scaffold(
      appBar: HistoryAppBar(
        onDeleteAll: () {
          DbProvider.db.deleteAllScan();
          _deleteAll();
        },
      ),
      backgroundColor: ThemeApp.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: historyList.length,
                itemBuilder: (context, index) {
                  return HistoryElementWidget(
                    name: historyList[index].value,
                    id: historyList[index].id!,
                    onDelete: () {
                      _deleteElement(index);
                      DbProvider.db.deleteScan(historyList[index].id!);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
