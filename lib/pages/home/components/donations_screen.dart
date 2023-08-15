import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/core/components/widgets/custom_input.dart';
import 'package:blood_donor_admin/core/components/widgets/smart_dialog.dart';
import 'package:blood_donor_admin/models/donation_model.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/functions.dart';
import '../../../state/data_sate.dart';
@RoutePage()
class DonationScreen extends ConsumerStatefulWidget {
  const DonationScreen({super.key});

  @override
  ConsumerState<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends ConsumerState<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    var donations = ref.watch(donationsStreamProvider);
    return  Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Donations'.toUpperCase(),
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
         
          Expanded(
            child: donations.when(
              data: (data) {
                return DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 12,
                  minWidth: 600,
                  empty: const Center(child: Text('No pending requests')),
                  columns: const [
                    DataColumn2(
                      label: Text(
                        'Donation Date',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(
                        'Donor Name',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text(
                        'Blood Type',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                     DataColumn2(
                      label: Text(
                        'Hospital Name',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(
                        'Action',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                  ],
                  rows: data
                      .map(
                        (e) => DataRow(
                          cells: [
                            DataCell(
                              Text(getDateFromDate(e.date))
                            ),
                            DataCell(
                              Text(
                                e.donorName??'',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                e.bloodGroup??'',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                               '${e.bloodQuantity??0} ml',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                e.hospitalName??'',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                             DataCell(
                              Text(
                                e.status??'',
                                style:  TextStyle(
                                    fontSize: 15,
                                    color: e.status=='Pending'?Colors.black:e.status=='Accepted'||e.status=='Done'?Colors.green:Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              PopupMenuButton(
                                onSelected: (value) => takeAction(value,e),
                                itemBuilder: (context) => [
                                  if(e.status=='Pending')
                                  const PopupMenuItem(
                                    value: 'Accepted',
                                    child: Text('Accept'),
                                  ),
                                   if(e.status=='Pending')
                                  const PopupMenuItem(
                                    value: 'Rejected',
                                    child: Text('Reject'),
                                  ),
                                   if(e.status=='Accepted')
                                   const PopupMenuItem(
                                    value: 'Cancelled',
                                    child: Text('Cancel'),
                                  ),
                                   if(e.status=='Accepted')
                                     const PopupMenuItem(
                                    value: 'Donated',
                                    child: Text('Mark as done'),
                                  ),
                                ]
                              )
                              ),
                          ],
                        ),
                      )
                      .toList());      
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (e, s) => Center(
                child: Text(e.toString()),
              ),
            ),
          ),
        ])
    );
  }
final textFieldController = TextEditingController();
  takeAction(String? value, DonationModel e) {
    if(value=='Accepted'){
      CustomDialog.showInfo(title: 'Accept Donation',
      onConfirmText: 'Accept',
      message: 'Are you sure you want to accept this donation request?', onConfirm: (){
        ref.read(donationsProvider.notifier).updateDonationStatus(e.id!, 'Accepted');
      });
    }else if(value=='Rejected'){
      ref.read(donationsProvider.notifier).updateDonationStatus(e.id!, 'Rejected');
    }else if(value=='Cancelled'){
      ref.read(donationsProvider.notifier).updateDonationStatus(e.id!, 'Cancelled');
    }else if(value=='Donated'){
      //show quantity dialog
      CustomDialog.dismiss();
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Text('Enter quantity'),
        content: CustomTextFields(
          controller: textFieldController,
          isDigitOnly: true,
          keyboardType: TextInputType.number,
          hintText: 'Quantity in pine',
        ),
        actions: [
          TextButton(onPressed: (){
            ref.read(donationsProvider.notifier).updateDonationStatus(e.id!, 'Donated', quantity: double.parse(textFieldController.text));
            Navigator.pop(context);
          }, child: const Text('Donated'))
        ],
      ));
  }
  }
}
