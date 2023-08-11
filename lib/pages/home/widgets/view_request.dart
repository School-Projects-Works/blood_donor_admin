import 'package:blood_donor_admin/models/request_model.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:blood_donor_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/components/widgets/smart_dialog.dart';
import '../../../state/data_sate.dart';

class ViewRequest extends ConsumerWidget {
  const ViewRequest({super.key, required this.request});
  final RequestModel request;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.6),
      body: LayoutBuilder(builder: (context, size) {
        return Center(
            child: Container(
          width: size.maxWidth > 800 && size.maxWidth <= 1100
              ? size.maxWidth * .7
              : size.maxWidth > 1100
                  ? size.maxWidth * .5
                  : size.maxWidth,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Blood Request',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  )),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
                ],
              ),
              const Divider(
                thickness: 3,
                color: primaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: primaryColor, width: 2),
                                image: request.patientImage != null
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(request.patientImage!),
                                        fit: BoxFit.cover)
                                    : null),
                            child: request.patientImage != null
                                ? null
                                : Icon(
                                    MdiIcons.bloodBag,
                                    size: 100,
                                    color: primaryColor,
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.account,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Patient Name: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    request.patientName!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.genderNonBinary,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Patient Gender: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    request.patientGender!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.calendar,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Patient Age: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    request.patientAge!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Divider(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.bed,
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Patient Condition: ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    request.patientCondition!,
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.hospitalBuilding,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hospital Name: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            request.hospitalName!,
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.phone,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hospital Phone: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            request.hospitalPhone!,
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.mapMarker,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hospital Address: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            request.hospitalAddress!,
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.bloodBag,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Blood Needed: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            request.bloodGroup!.join(', '),
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.scaleBalance,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Quantity Needed: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${request.bloodNeeded} Pints',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.scale,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Quantity Donated: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${request.bloodDonated} Pints',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.accountMultiple,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Donors: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${request.donors!.length} Donors',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.account,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Requested By: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${request.requester!['name']}',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: request.isCompleted!
                              ? Colors.green.withOpacity(.6)
                              : Colors.red.withOpacity(.6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.checkAll,
                              color: primaryColor,
                            ),
                            Text(
                              'Status: ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              request.status!,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          //action buttons
                          if (request.status == 'Published')
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  CustomDialog.showInfo(
                                    title: 'Mark as Completed',
                                    onConfirmText: 'Completed',
                                    onConfirm: () {
                                      ref
                                          .read(singleRequestProvider.notifier)
                                          .markComplete(
                                              'Completed', request.id!);
                                    },
                                    message:
                                        'Are you sure you want to mark this request as completed?',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  'Mark as Completed',
                                  style: normalText(color: Colors.white),
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (request.status == 'Pending')
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  CustomDialog.showInfo(
                                    title: 'Publish Request',
                                    onConfirmText: 'Publish',
                                    onConfirm: () {
                                      ref
                                          .read(singleRequestProvider.notifier)
                                          .changeStatus(
                                              'Published', request.id!);
                                    },
                                    message:
                                        'Are you sure you want to publish this request?',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  'Publish Request',
                                  style: normalText(color: Colors.white),
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 15,
                          ),
                          if (request.status == 'Pending')
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  CustomDialog.showInfo(
                                    title: 'Reject Request',
                                    onConfirmText: 'Reject',
                                    onConfirm: () {
                                      ref
                                          .read(singleRequestProvider.notifier)
                                          .changeStatus(
                                              'Rejected', request.id!);
                                    },
                                    message:
                                        'Are you sure you want to reject this request?',
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  'Reject Request',
                                  style: normalText(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ));
      }),
    );
  }
}
