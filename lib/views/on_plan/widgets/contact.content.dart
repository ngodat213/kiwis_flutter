import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/views/on_plan/on_plan_controller.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:kiwis_flutter/widgets/custom_elevated_button.dart';

class ContactContent extends GetView<OnPlanController> {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.5,
                width: Get.width * 0.9,
                child: controller.listContacts.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: Get.height * 0.5,
                        child: ListView.builder(
                          itemCount: controller.listContacts.length,
                          itemBuilder: (context, index) {
                            Contact contact = controller.listContacts[index];
                            return ListTile(
                              title: Text(contact.displayName),
                              subtitle: Text(contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : 'Không có số'),
                            );
                          },
                        ),
                      ),
              ),
              SizedBox(height: 10),
              CustomElevatedButton(
                onPressed: () => Get.back(),
                text: "Chọn",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
