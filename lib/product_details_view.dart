import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';

/// Displays detailed information about a SampleItem.
class ProductItemDetailsView extends StatelessWidget {
  const ProductItemDetailsView({super.key});

  static const routeName = '/product_item';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final arguments = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              arguments.assetName,
              package: arguments.assetPackage,
              // TODO: Adjust the box size (102)
            ),
          ),
          Text(
            arguments.name,
            style: theme.textTheme.titleLarge,
            maxLines: 1,
          ),
          const SizedBox(height: 8.0),
          Text(
            formatter.format(arguments.price),
            style: theme.textTheme.titleSmall,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final model = Provider.of<AppStateModel>(context, listen: false);
              model.addProductToCart(arguments.id);
            },
            child: const Icon(
              CupertinoIcons.plus_circled,
              semanticLabel: 'Add',
            ),
          ),
        ],
      ),
    );
  }
}
