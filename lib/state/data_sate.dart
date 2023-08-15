
import 'package:blood_donor_admin/core/components/widgets/smart_dialog.dart';
import 'package:blood_donor_admin/models/donation_model.dart';
import 'package:blood_donor_admin/models/request_model.dart';
import 'package:blood_donor_admin/models/user_model.dart';
import 'package:blood_donor_admin/services/firebase_fireStore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final donationsStreamProvider= StreamProvider.autoDispose<List<DonationModel>>((ref)async* {
  final donations= FireStoreServices.getAllDonationsStream();
  ref.onDispose(() => donations.drain());
  List<DonationModel> donationList= [];
  await for (var donation in donations) {
    donationList= donation.docs.map((e) => DonationModel.fromMap(e.data())).toList();
    yield donationList;
  }
});

final requestsStreamProvider= StreamProvider.autoDispose<List<RequestModel>>((ref)async* {
  final requests= FireStoreServices.getRequestStream();
  ref.onDispose(() => requests.drain());
  List<RequestModel> requestList= [];
  await for (var request in requests) {
    requestList= request.docs.map((e) => RequestModel.fromMap(e.data())).toList();
    yield requestList;
  }
});

final usersStreamProvider= StreamProvider.autoDispose<List<UserModel>>((ref)async* {
  final users= FireStoreServices.getUsersStream();
  ref.onDispose(() => users.drain());
  List<UserModel> userList= [];
  await for (var user in users) {
    userList= user.docs.map((e) => UserModel.fromMap(e.data())).toList();
    yield userList;
  }
});

final singleRequestProvider = StateNotifierProvider<RequestProvider, void>((ref){
  return RequestProvider();

});

class RequestProvider extends StateNotifier<void> {
  RequestProvider() : super(null);
  void changeStatus(String status, String id)async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Please wait...Updating status');
    var response= await FireStoreServices.changeRequestStatus(status, id);
    if(response){
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: 'Status updated successfully',title: 'Success');
    }else{
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to update status',title: 'Error');
    }

  }

  void markComplete(String s, String t) async{
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Please wait...Marking as complete');
    var response= await FireStoreServices.markRequestAsCompleted(s, t);
    if(response){
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: 'Request marked as complete successfully',title: 'Success');
    }else{
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to mark request as complete',title: 'Error');
    }
  }
}
final singleUserProvider = StateNotifierProvider<SingleUserProvider, void>((ref){
  return SingleUserProvider();

});

class SingleUserProvider extends StateNotifier<void> {
  SingleUserProvider() : super(null);
  void changeStatus(String status, String id)async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Please wait...Updating status');
    var response= await FireStoreServices.changeUserStatus(status, id);
    if(response){
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: 'Status updated successfully',title: 'Success');
    }else{
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to update status',title: 'Error');
    }

  }
}


final donationsProvider = StateNotifierProvider<DonationProvider, void>((ref){
  return DonationProvider();

});

class DonationProvider extends StateNotifier<void> {
  DonationProvider() : super(null);

  void updateDonationStatus(String id, String status, { double? quantity})async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Please wait...Updating status');
    await FireStoreServices.updateDonationStatus(id, status, quantity: quantity).then((value) {
      if(value){
        CustomDialog.dismiss();
        CustomDialog.showSuccess(message: 'Status updated successfully',title: 'Success');
      }else{
        CustomDialog.dismiss();
        CustomDialog.showError(message: 'Failed to update status',title: 'Error');
      }
    });
  }
 
}