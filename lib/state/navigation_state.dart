import 'package:blood_donor_admin/core/components/constants/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final sideBarWithProvider= StateProvider<double>((ref) => 60);

final navigationPageProvider=StateProvider<HomePages>((ref)=>HomePages.dashboard);