import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/component/custom_linear_text_widget.dart';
import 'package:matlop_provider/core/utils/constant_model.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/manager/walletCubit/cubit/wallet_cubit.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/views/addNewTransaction/new_transaction.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/widgets/balanc_card.dart';
import 'package:matlop_provider/feature/menu/views/wallet/presentation/widgets/financial_transaction_card.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WalletCubit.of(context).getWalletData(context);
      WalletCubit.of(context).getTransactions(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final transactions = ConstantModel.transactionsModel?.data;

        return Scaffold(
          // persistentFooterButtons: [
          //   CustomTextButton(
          //     width: MediaQuery.sizeOf(context).width,
          //     borderRadius: 15,
          //     child: Text(
          //       'New transaction'.tr(), // Added .tr()
          //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          //     ),
          //     onPress: () {},
          //   ),
          // ],
          appBar: CustomAppBar(title: 'Wallet'.tr()), // Added .tr()
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: BalanceCard(
                    balance: (ConstantModel.walletModel?.data?.balance ?? 0.0).toDouble(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextButton(
                    linearBorder: true,
                    borderRadius: 16,
                    // borderColor: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    child: const CustomLinearTextWidget(
                      text: 'Withdraw balance',
                    ),
                    onPress: () {
                      WalletCubit.of(context).amountController.clear();
                      WalletCubit.of(context).ibanController.clear();
                      WalletCubit.of(context).accountNameController.clear();
                      WalletCubit.of(context).bankNameController.clear();
                      context.navigateToPage(const NewTransaction());
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Financial transactions'.tr(), // Added .tr()
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: transactions == null || transactions.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'No transactions available'.tr(), // Added .tr()
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (transactions != null && transactions.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FinancialTransactionCard(
                          withdraw: transactions[index],
                        );
                      },
                      childCount: transactions.length,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
