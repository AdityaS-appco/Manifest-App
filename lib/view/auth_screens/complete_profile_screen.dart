import 'package:manifest/core/shared/widgets/app_textfield.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/select_date_of_birth_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/buttons/primary_page_button.dart';
import 'package:manifest/core/shared/widgets/chips/selectable_chip.dart';
import 'package:manifest/controllers/auth_controller/auth_controller.dart';
import 'package:manifest/helper/import.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return CommonAuthFormScaffold(
          title: AppStrings.completeProfileTitle,
          subtitle: AppStrings.completeProfileSubtitle,
          formKey: formKey,
          isBackButtonVisible: false,
          hasStarSplash: true,
          bottomsheet: PrimaryPageButton.text(
            text: 'Finish',
            onPressed: () {
              if (controller.nameController.text.isEmpty) {
                ToastUtil.error('Please enter a nickname');
              } else if (controller.dateOfBirth == null) {
                ToastUtil.error('Please select a date of birth');
              } else if (controller.selectGender.isEmpty) {
                ToastUtil.error('Please select a gender');
              } else {
                controller.completeProfile();
              }
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                title: AppStrings.name,
                hintText: 'Unknown',
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterNicknameError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AppTextField(
                title: AppStrings.dateOfBirth,
                hintText: 'Unknown',
                controller: controller.dateOfBirthController,
                validator: FormValidatorUtil.dateOfBirth,
                readOnly: true,
                onTextFieldTap: () {
                  AppBottomSheet.show(
                    SelectDateOfBirthBottomsheet(
                      selectedDate: controller.dateOfBirth,
                      onSavePressed: (selectedDate) {
                        if (selectedDate != null) {
                          /// * set the date of birth
                          controller.setDateOfBirth(selectedDate);
                          Get.back();
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.gender,
                style: Get.appTextTheme.textFieldTitle,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: GenderType.values.map((gender) {
                  return SizedBox(
                    width: 100.w,
                    child: Obx(
                      () => SelectableChip(
                        label: gender.name,
                        isSelected: controller.selectGender == gender.name,
                        onTap: () {
                          controller.setSelectedGender(gender.name);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
