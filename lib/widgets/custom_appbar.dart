import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanner_app/constants/colors.dart';

//CustomHomeScreenAppbar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.title});
final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {


    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(color: globalColors.WhiteColor),
      leading: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 0),
              child: SizedBox(
                height: 15,
                width: 15,
                child: SvgPicture.asset(
                  "assets/images/Drawer_Icon_2.svg",
                ),
              ),
            ),
          );
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: globalColors.WhiteColor),
      ),
      elevation: 0.9,
      backgroundColor: globalColors.primaryColor,
    );
  }
}
