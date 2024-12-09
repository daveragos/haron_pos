import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/data/model/order.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/data/repository/order_repo.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RightPane extends StatelessWidget {
  const RightPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.accentColor.withOpacity(0.2),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Spacer(),
              const Text(
                'Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<ProductBloc>().add(ClearCart());
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          // Table Header
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item'),
                Text('Quantity'),
                Text('Price'),
              ],
            ),
          ),
          // Cart Items
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final cartProducts = context.read<ProductBloc>().cartProducts;

                  if (cartProducts.isEmpty) {
                    return const Center(child: Text("Cart is empty"));
                  }

                  return ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.name),
                            Text(product.quantity.toString()),
                            Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text("Cart is empty"));
              },
            ),
          ),
          // Total Amount
          Padding(
  padding: const EdgeInsets.all(8.0),
  child: BlocBuilder<ProductBloc, ProductState>(
    builder: (context, state) {
      final cartProducts = context.read<ProductBloc>().cartProducts;

      final total = cartProducts.fold(
        0.0,
        (sum, product) => sum + product.price * product.quantity,
      );

      return Text(
        'Total: \$${total.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
    },
  ),
),

          // Checkout Button
          ElevatedButton(
  onPressed: () async {
    final bloc = context.read<ProductBloc>();
    final cartProducts = bloc.cartProducts;
    final totalAmount = cartProducts.fold(
      0.0,
      (sum, product) => sum + product.price * product.quantity,
    );

    // Create the Order object
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      products: cartProducts,
      totalAmount: totalAmount,
      date: DateTime.now(),
    );

    // Store the order in Hive
    await storeOrder(order);

    // Generate and save PDF
    final content = [
      pw.Text('Haron POS Invoice', style: pw.TextStyle(fontSize: 24)),
      pw.SizedBox(height: 20),
      ...cartProducts.map((product) {
        return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(product.name),
            pw.Text('${product.quantity}'),
            pw.Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
          ],
        );
      }),
      pw.Divider(),
      pw.Text('Total: \$${totalAmount.toStringAsFixed(2)}',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
    ];

    // Save the PDF
    await savePdf(content);

    // Optionally open the saved PDF (on Windows)
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/haron_pos_invoice.pdf');
    await Process.run('start', [file.path], runInShell: true);
  },
  child: const Text('Checkout'),
)

        ],
      ),
    );
  }
}


Future<void> savePdf(List<pw.Widget> content) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: content,
        );
      },
    ),
  );

  // Get the directory to save the file
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/haron_pos_invoice.pdf');

  // Save the file
  await file.writeAsBytes(await pdf.save());

  print('PDF saved at ${file.path}');
}




Future<Uint8List> generatePdf(List<Product> cartProducts, double totalAmount) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Haron POS Invoice',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Text('Date: ${DateTime.now().toLocal()}'),
            pw.SizedBox(height: 20),

            // Table Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Product', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.Divider(),

            // Table Rows
            ...cartProducts.map(
              (product) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(product.name),
                  pw.Text('${product.quantity}'),
                  pw.Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                ],
              ),
            ),

            pw.Divider(),
            pw.SizedBox(height: 20),

            // Total Amount
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total: \$${totalAmount.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}
