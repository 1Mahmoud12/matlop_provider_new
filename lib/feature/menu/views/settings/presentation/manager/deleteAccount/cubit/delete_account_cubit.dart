// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_workers/core/component/loading_widget.dart';
// import 'package:user_workers/core/utils/utils.dart';
// import 'package:user_workers/features/auth/login/presentation/login_view.dart';
// import 'package:user_workers/features/auth/login/presentation/manager/cubit/login_cubit.dart';
// import 'package:user_workers/features/menu/views/settings/data/dataSource/delete_account_data_source.dart';
// part 'delete_account_state.dart';

// class DeleteAccountCubit extends Cubit<DeleteAccountState> {
//   DeleteAccountCubit() : super(DeleteAccountInitial());
//   static DeleteAccountCubit of(BuildContext context) => BlocProvider.of<DeleteAccountCubit>(context);
//   void deleteAccount(BuildContext context) async {
//     animationDialogLoading(context);

//     await DeleteAccountDataSource.deleteAccount(context: context).then(
//       (value) {
//         value.fold((l) {
//           Utils.showToast(title: l.errMessage, state: UtilState.error);
//           emit(DeleteAccountError(e: l.errMessage));
//         }, (r) {
//           emit(DeleteAccountSuccess());

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) {
//                 return BlocProvider(
//                   create: (context) => LoginCubit(),
//                   child: const PopScope(
//                     canPop: false,
//                     // onPopInvokedWithResult: (didPop, result) {
//                     //   if (didPop) {
//                     //     SystemNavigator.pop();
//                     //   }
//                     // },
//                     child: LoginView(),
//                   ),
//                 );
//               },
//             ),
//           );
//         });
//       },
//     );
//   }
// }
