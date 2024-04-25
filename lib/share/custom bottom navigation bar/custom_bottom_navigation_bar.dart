// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields, use_key_in_widget_constructors, unused_import, unused_local_variable, deprecated_member_use

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scanner_app/constants/colors.dart';
import 'package:scanner_app/widgets/custom_Text_Widget.dart';
import '../../scanners/EfficientNent/EfficientNent.dart';
import '../../scanners/MobileNet/MobileNet.dart';
import '../../scanners/ResNet50/ResNet50.dart';
import '../../scanners/VGG16/pickImage.dart';
import '../../widgets/custom_appbar.dart';

class CustomBottomNavigationbar extends StatefulWidget {
  const CustomBottomNavigationbar({super.key});

  @override
  State<CustomBottomNavigationbar> createState() =>
      _CustomBottomNavigationbarState();
}

class _CustomBottomNavigationbarState extends State<CustomBottomNavigationbar> {
  int _currentindex = 0;

  List<Widget> ScreenList = [
    PickImage(),
    MobileNet(),
    EfficientNent(),
    ResNet50(),
  ];
  List<String> AppbarTitleList = [
    'VGG16',
    'MobileNet',
    "EfficientNent",
    "ResNet50",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalColors.primaryColor,
        centerTitle: true,
        title: CustomText(
          text: AppbarTitleList[_currentindex],
          color: globalColors.WhiteColor,
          fontsize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ScreenList[_currentindex],
      extendBody: true,
      backgroundColor: globalColors.primaryColor,

      // bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: globalColors.primaryColor,
        selectedItemColor: globalColors.primaryColor,
        unselectedItemColor: globalColors.BlackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: List.generate(
          ScreenList.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.barcode_viewfinder),
            label: AppbarTitleList[index],
          ),
        ),
        currentIndex: _currentindex,
        onTap: (value) {
          try {
            if (value >= 0 && value < ScreenList.length) {
              setState(() {
                _currentindex = value;
              });
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
