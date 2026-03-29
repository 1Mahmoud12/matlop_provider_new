import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/dataSource/wallet_data_source.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/wallet_params.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  static WalletCubit of(BuildContext context) => BlocProvider.of<WalletCubit>(context);

  WalletDataSourceAbstract walletDataSourceAbstract = WalletDataSource();

  Future<void> getWalletData(BuildContext context) async {
    emit(WalletLoading());
    animationDialogLoading(
      context,
    );
    await walletDataSourceAbstract.getBalanceData().then((value) async{
      if(context.mounted)closeDialog(context);
      value.fold((l) {
       // Utils.showToast(title: l.errMessage, state: UtilState.error);
        emit(WalletError(e: l.errMessage));
      }, (r) {
        ConstantModel.walletModel = r;

        emit(WalletSuccess());
      });
    });
  }

  Future<void> getTransactions(BuildContext context) async {
    emit(TransactionsLoading());
    animationDialogLoading(
      context,
    );
    await walletDataSourceAbstract.getTransactions().then((value) {
      closeDialog(context);
      value.fold((l) {
      //  Utils.showToast(title: l.errMessage, state: UtilState.error);
        emit(TransactionsError(e: l.errMessage));
      }, (r) {
        ConstantModel.transactionsModel = r;

        emit(TransactionsSuccess());
      });
    });
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  Future<void> addTransaction(BuildContext context, int transactionType) async {
    animationDialogLoading(
      context,
    );
    await walletDataSourceAbstract
        .addWallet(
            params: WalletParams(
                amount: num.parse(amountController.text),
               accountName: accountNameController.text,
                transactionType: transactionType,
               iban: ibanController.text,
               bankName: bankNameController.text,
                userId: userCacheValue?.data?.userId ?? -1))
        .then((value) {
      closeDialog(context);
      value.fold((l) {
        Utils.showToast(title: l.errMessage, state: UtilState.error);
        emit(WalletError(e: l.errMessage));
      }, (r) async {
        Utils.showToast(title: r, state: UtilState.success);
        if(context.mounted) {
          await getTransactions(context);
          await getWalletData(context);
          Navigator.pop(context);
        }
        emit(WalletSuccess());
      });
    });
  }
}
