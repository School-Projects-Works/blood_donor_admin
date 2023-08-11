import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/core/components/widgets/custom_button.dart';
import 'package:blood_donor_admin/core/components/widgets/smart_dialog.dart';
import 'package:blood_donor_admin/core/functions.dart';
import 'package:blood_donor_admin/models/request_model.dart';
import 'package:blood_donor_admin/pages/home/widgets/view_request.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:blood_donor_admin/styles/styles.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../state/data_sate.dart';
import '../widgets/dashboard_item.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var donations = ref.watch(donationsStreamProvider);
    var requests = ref.watch(requestsStreamProvider);
    var users = ref.watch(usersStreamProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Dashboard'.toUpperCase(),
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold, color: secondaryColor),
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
            donations.when(
              data: (data) {
                return DashboardItem(
                  title: 'Total Donations',
                  value: data.length.toDouble(),
                  color: Colors.red,
                  icon: MdiIcons.heart,
                );
              },
              loading: () => const DashboardItem(
                loading: true,
                color: Colors.red,
              ),
              error: (error, stack) => const DashboardItem(
                error: true,
                color: Colors.red,
              ),
            ),
            requests.when(
              data: (data) {
                return DashboardItem(
                  title: 'Total Requests',
                  value: data.length.toDouble(),
                  color: Colors.blue,
                  icon: MdiIcons.checkAll,
                );
              },
              loading: () => const DashboardItem(
                loading: true,
                color: Colors.blue,
              ),
              error: (error, stack) => const DashboardItem(
                error: true,
                color: Colors.blue,
              ),
            ),
            users.when(
              data: (data) {
                return DashboardItem(
                  title: 'Total Users',
                  value: data.length.toDouble(),
                  color: Colors.green,
                  icon: MdiIcons.account,
                );
              },
              loading: () => const DashboardItem(
                loading: true,
                color: Colors.green,
              ),
              error: (error, stack) => const DashboardItem(
                error: true,
                color: Colors.green,
              ),
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
                Text(
                  'Pending Requests'.toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                  text: 'Make Request',
                  color: secondaryColor,
                  onPressed: () {},
                  icon: MdiIcons.plus,
                )
              ],
            )),

        Expanded(
          child: requests.when(data: (data){
            var incompleteRequests = data.where((element) => element.isCompleted ==false).toList();
            return DataTable2(
              columnSpacing: 15,
              horizontalMargin: 12,
              minWidth: 600,
              empty: const Center(child: Text('No pending requests')),
              columns: [
                DataColumn2(
                  label: Text(
                    'Date',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  
                ),
                DataColumn2(
                  label: Text(
                    'Requester',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  label: Text(
                    'Blood Group',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  label: Text(
                    'Quantity\nNeeded',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                   size: ColumnSize.S
                ),
                DataColumn2(
                   size: ColumnSize.S,
                  label: Text(
                    'Quantity\nReceived',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  label: Text(
                    'Patient\nCondition',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  size: ColumnSize.L,
                  label: Text(
                    'Hospital',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  label: Text(
                    'Actions',
                    style:
                        normalText(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                size: ColumnSize.S
                ),
              ],
              rows: incompleteRequests.map((e) => DataRow(cells: [
                        DataCell(Text(getDateFromDate(e.createdAt))),
                        DataCell(Text(e.requester!['name'])),
                        DataCell(Text(e.bloodGroup!.join(', '))),
                        DataCell(Text('${e.bloodNeeded.toString()} pints')),
                        DataCell(Text('${e.bloodDonated.toString()} pints')),
                        DataCell(Text(e.patientCondition!)),
                        DataCell(Text(e.hospitalName!)),
                        DataCell(Text(e.status!,style: TextStyle(color: e.status=='Published'?Colors.green:e.status=='Rejected'?Colors.red:Colors.black),)),
                        DataCell(PopupMenuButton(
                          onSelected: (value) => takeAction(value,e),
                          icon: const Icon(
                            Icons.apps,
                            color: primaryColor,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'View',
                              child: Text('View'),
                            ),
                            if(e.isCompleted==false&&e.status=='Pending') const PopupMenuItem(
                              value: 'Publish',
                              child: Text('Publish'),
                            ),
                            if(e.isCompleted==false&&e.status=='Pending')
                            const PopupMenuItem(
                              value: 'Reject',
                              child: Text('Reject'),
                            ),
                            if(e.status=='Published') const PopupMenuItem(
                              value: 'Mark as Completed',
                              child: Text('Mark as Completed'),
                            )
                          ],
                        )),
                      ])).toList(),);
       
          }, error: (e,s){
            return const Center(child: Text('Something went wrong'));
          }, loading: ()=> const Center(child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator()),),),)
          
      ]),
    );
  }
  
  takeAction(String value, RequestModel request) {
    switch (value) {
      case 'View':
      sendToTransparentPage(context, ViewRequest(request:request ));
        break;
      case 'Publish':
       CustomDialog.showInfo(title: 'Publish Request', onConfirmText: 'Publish',
       onConfirm: (){
          ref.read(singleRequestProvider.notifier).changeStatus('Published', request.id!);
        }, message: 'Are you sure you want to publish this request?',
       
       );
        break;
      case 'Reject':
        CustomDialog.showInfo(title: 'Reject Request', onConfirmText: 'Reject',
        onConfirm: (){
            ref.read(singleRequestProvider.notifier).changeStatus('Rejected', request.id!);
          }, message: 'Are you sure you want to reject this request?',
        );
        break;
      case 'Mark as Completed':
        CustomDialog.showInfo(title: 'Mark as Completed', onConfirmText: 'Completed',
        onConfirm: (){
            ref.read(singleRequestProvider.notifier).markComplete('Completed', request.id!);
          }, message: 'Are you sure you want to mark this request as completed?',
        );
        break;
      default:
      break;
  }
}
}
