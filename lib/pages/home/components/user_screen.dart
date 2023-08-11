import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/core/components/widgets/smart_dialog.dart';
import 'package:blood_donor_admin/core/functions.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../state/data_sate.dart';
import '../../../styles/styles.dart';

@RoutePage()
class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    var users = ref.watch(usersStreamProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users'.toUpperCase(),
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
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: users.when(
              data: (data) {
                return DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 12,
                  minWidth: 600,
                  empty: const Center(child: Text('No pending requests')),
                  columns: [
                    DataColumn2(
                      label: Text(
                        'Image',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(
                        'Name',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn2(
                       size: ColumnSize.S,
                      label: Text(
                        'Gender',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn2(
                       size: ColumnSize.S,
                      label: Text(
                        'Date of\nBirh',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn2(
                        label: Text(
                          'Email',
                          style: normalText(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        size: ColumnSize.L),
                    DataColumn2(
                        label: Text(
                          'Contact',
                          style: normalText(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: Text(
                        'Address',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      
                    ),
                    DataColumn2(
                      label: Text(
                        'Join At',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn2(
                      label: Text(
                        'Status',
                        style: normalText(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                        label: Text(
                          'Actions',
                          style: normalText(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        size: ColumnSize.S),
                  ],
                  rows: data
                      .map((e) => DataRow(cells: [
                            DataCell(InkWell(
                              onTap: (){
                                CustomDialog.showImageDialog(path: e.profileUrl ??
                                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png');
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(e.profileUrl ??
                                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                              ),
                            )),
                            DataCell(Text(e.name ?? '')),
                            DataCell(Text(e.gender ?? '')),
                            DataCell(Text(e.dob ?? '')),
                            DataCell(Text(e.email ?? '')),
                            DataCell(Text(e.phone ?? '')),
                            DataCell(Text(
                                '${e.address ?? ''} - ${e.city ?? ''}, ${e.region ?? ''}')),
                            DataCell(Text(getDateFromDate(e.createdAt))),
                            DataCell(Text(
                              e.status!,
                              style: TextStyle(
                                  color: e.status == 'Enabled'
                                      ? Colors.green
                                      : Colors.red),
                            )),
                            DataCell(Row(
                              children: [
                                Switch(
                                    value: e.status == 'Enabled' ? true : false,
                                    onChanged: (value) {
                                      ref
                                          .read(singleUserProvider.notifier)
                                          .changeStatus(
                                              value ? 'Enabled' : 'Disabled',
                                              e.uid!);
                                    }),
                                IconButton(
                                    onPressed: () {
                                      
                                    },
                                    icon:  Icon(
                                      MdiIcons.eye,
                                      color: Colors.black,
                                    ))
                              ],
                            )),
                          ]))
                      .toList(),
                );
              },
              error: (e, s) {
                return const Center(child: Text('Something went wrong'));
              },
              loading: () => const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
