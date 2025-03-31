import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../common/common_appbar.dart';
import '../model/item_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController noteController = TextEditingController();
  bool isPublic = false;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Add Note", showBackButton: true, hideLogo: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: noteController,
              decoration: InputDecoration(hintText: "Enter your notes.."),
            ),
            Row(
              children: [
                Checkbox(value: isPublic, onChanged: (val) => setState(() => isPublic = val!)),
                Text("Is public note?")
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => selectedDate = picked);
              },
              child: Text("${selectedDate.month}/${selectedDate.day}/${selectedDate.year.toString().substring(2)}"),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(result: ItemNote(note: noteController.text, date: selectedDate, isPublic: isPublic)),
                  child: Text("Save"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
