import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/DrawerScreenProvider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
                child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Text("YWork Admin Panel"),
              ],
            )),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Provider.of<DrawerScreenProvider>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.dashboard);
            },
          ),
          // DrawerListTile(
          //   title: "Transaction",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Purchase Details",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Provider.of<DrawerScreenProvider>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.dashboard);
            },
          ),
          DrawerListTile(
            title: "Add Mall",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<DrawerScreenProvider>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.addMall);
            },
          ),
          DrawerListTile(
            title: "Add Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Provider.of<DrawerScreenProvider>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.addStore);
            },
          ),

          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Add Agent",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Provider.of<DrawerScreenProvider>(context, listen: false)
                  .changeCurrentScreen(CustomScreensEnum.addAgent);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
