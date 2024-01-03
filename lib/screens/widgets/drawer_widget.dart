import 'package:flutter/material.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';

import '../../data/sessionManager/session_manager.dart';
import '../../injection_container.dart';
import '../../resources/image_resources.dart';
import 'drawer_list_item_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late final List<Map<String, String>> drawerItemList;

  @override
  void initState() {
    super.initState();
    drawerItemList = [
      {'icon': ImageResources.homeIcon, 'title': 'Home'}, //0
      {'icon': ImageResources.homeIcon, 'title': 'Ndume Training'}, //1
      {'icon': ImageResources.myFarmerIcon, 'title': 'My Farmers'}, //2
      {'icon': ImageResources.breedingRecordIcon, 'title': 'Breeding Records'}, //3
      {'icon': ImageResources.healthRecordsIcon, 'title': 'Health Records'}, //4
      {'icon': ImageResources.walletIcon, 'title': 'Ndume Wallet'}, //5
      {'icon': ImageResources.passwordIcon, 'title': 'Change Passwords'}, //6
      {'icon': ImageResources.logoutIcon, 'title': 'Logout'}, //7
      /*{'icon': ImageResources.shareIcon, 'title': 'Invite'},*/ //8
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 180,
              color: ColorConstants.appColor,
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 95,
                      width: 95,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Image.asset(
                          ImageResources.circularAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      /*'UserName', */
                      sl<SessionManager>().getUserDetails()!.data!.vetFname!,
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemBuilder: (_, i) {
                  return DrawerListItemWidget(
                    title: drawerItemList[i]['title'].toString(),
                    icon: drawerItemList[i]['icon'].toString(),
                    index: i,
                    isHelpInfoIcon: i == 6,
                  );
                },
                itemCount: drawerItemList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
