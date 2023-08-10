import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/pages/home/widgets/side_bar.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../generated/assets.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: LayoutBuilder(builder: (context, sized) {
        return Scaffold(
          appBar: sized.maxWidth <= 950
              ? AppBar(
                  backgroundColor: primaryColor,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      if (sized.maxWidth <= 950)
                        IconButton(
                            onPressed: () {
                              //check if drawer is open
                              if (scaffoldKey.currentState!.isDrawerOpen) {
                                scaffoldKey.currentState!.openEndDrawer();
                              } else {
                                scaffoldKey.currentState!.openDrawer();
                              }
                            },
                            icon: Icon(
                              scaffoldKey.currentState!.isDrawerOpen
                                  ? Icons.close
                                  : Icons.menu,
                              color: Colors.white,
                            )),
                      Image.asset(
                        Assets.logosIconWhite,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Blood Donor Admin',
                        style: GoogleFonts.robotoSlab(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      )
                    ],
                  ),
                  centerTitle: true,
                )
              : null,
          body: Scaffold(
            key: scaffoldKey,
            drawer: sized.maxWidth <= 950 ? const SideBar() : null,
            body: sized.maxWidth >= 950
                ? Column(
                    children: [
                      Container(
                        color: primaryColor,
                        padding: const EdgeInsets.all(15),
                        child: Row(children: [
                          Image.asset(
                            Assets.logosIconWhite,
                            height: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Blood Donor Admin',
                            style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.white),
                          )
                        ]),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SideBar(),
                            Expanded(
                              child: AutoRouter(),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const AutoRouter(),
          ),
        );
      }),
    );
  }
}
