import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_app/theme/theme.dart';

class AppButtonWidget extends StatelessWidget {
  final Icon icon;
  final String label;
  final function;
  const AppButtonWidget({super.key, required this.icon, required this.label, required this.function});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          child: NeumorphicButton(
            style: NeumorphicStyle(
              color: ThemeApp.primary,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(100),
              ),
            ),
            onPressed: function,
            child: icon,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          label,
          style: GoogleFonts.sora(color: ThemeApp.secondary, fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
