import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class SalesTemplateFieldScreen extends StatefulWidget {
  var title,txtField,detail;
   SalesTemplateFieldScreen({super.key,this.title,this.txtField,this.detail});

  @override
  State<SalesTemplateFieldScreen> createState() => _SalesTemplateFieldScreenState();
}

class _SalesTemplateFieldScreenState extends State<SalesTemplateFieldScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> tags = [
    'COMPANY.ADDR1',
    'COMPANY.CURRENCY',
    'COMPANY.EMAIL',
    'COMPANY.LOGO',
    'COMPANY.NAME',
    'CUSTOMER.ADDR1',
    'CUSTOMER.NAME',
    'LINE.AMOUNT',
    'LINE.PRICE',
    'TXN.DATE',
    'TXN.STATUS',
    'TXN.TYPE',
    'TXN.TOTAL',
    'TXN.TAX1LABEL',
    'USER.NAME',
    'SALE.TOTALLABELS',
    // Add more as needed...
  ];

  void _showTagsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select a Tag'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tags[index]),
                onTap: () {
                  setState(() {
                    _controller.text += ' ${tags[index]}';
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Jumla Sales Template",hideLogo: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Expanded(
                    child: Text(
                      widget.title.toString(),
                      style: AppTextStyles.medium(fontSize: 18.0, fontColor: AppStorages.appColor.value),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showTagsDialog,
                    child: const Text('Tags'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    child: const Text('Save changes'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade200,
                child: const Text(
                  'Your company name or any free-text.\n\nCompany details can be set at Print Setup > Settings tab > Company Information.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
