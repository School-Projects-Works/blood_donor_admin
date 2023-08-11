import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/core/components/widgets/custom_button.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:blood_donor_admin/styles/styles.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/dashboard_item.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
         Align(
            alignment: Alignment.centerLeft,
           child: Text(
            'Dashboard',
            style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
                 ),
         ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            DashboardItem(
              title: 'Total Donations',
              value: 100,
              color: Colors.red,
              icon: MdiIcons.heart,
              
            ),
            DashboardItem(
              title: 'Total Requests',
              value: 100,
              color: Colors.blue,
              icon: MdiIcons.checkAll,
            ),
            DashboardItem(
              title: 'Total Users',
              value: 100,
              color: Colors.green,
              icon: MdiIcons.account,
            ),
      
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Align(
            alignment: Alignment.centerLeft,
           
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pending Requests',  style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),),
              const SizedBox(width: 10,),
              CustomButton(text: 'Make Request', onPressed: (){

              },icon: MdiIcons.plus,)
            ],
          )),
          Expanded(            
            child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: [
              DataColumn2(
                label: Text('Date',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Requester',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              DataColumn(
                label: Text('Blood Group',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              DataColumn(
                label: Text('Quantity Needed',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
               DataColumn(
                label: Text('Quantity Received',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
               DataColumn(
                label: Text('Patient Condition',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              DataColumn(
                label: Text('Hospital',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
                numeric: true,
              ),
               DataColumn(
                label: Text('Actions',style: normalText(fontSize: 15,fontWeight: FontWeight.bold),),
                numeric: true,
              ),
            ],
            rows: List<DataRow>.generate(
                15,
                (index) => DataRow(cells: [
                      DataCell(Text('A' * (10 - index % 10))),
                      DataCell(Text('B' * (10 - (index + 5) % 10))),
                       DataCell(Text('B' * (10 - (index + 5) % 10))),
                      DataCell(Text('C' * (15 - (index + 5) % 10))),
                      DataCell(Text('D' * (15 - (index + 10) % 10))),
                       DataCell(Text('D' * (15 - (index + 10) % 10))),
                      DataCell(Text(((index + 0.1) * 25.4).toString())),
                       DataCell(PopupMenuButton(
                        onSelected: (value) => print(value),
                          icon: const Icon(Icons.apps,color: primaryColor,),
                         itemBuilder: (context) => [
                           const PopupMenuItem(
                            value: 'View',
                             child: Text('View'),
                           ),
                           const PopupMenuItem(
                              value: 'Publish',
                             child: Text('Publish'),
                           ),
                            const PopupMenuItem(
                              value: 'Reject',
                             child: Text('Reject'),
                           ),
                            const PopupMenuItem(
                              value: 'Delete',
                             child: Text('Delete'),
                           ),
                         ],
                       )),
                    ]))),
          ),
      ]),
    );
  }
}
