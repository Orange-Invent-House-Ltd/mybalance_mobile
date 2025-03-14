import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/custom_dropdown.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../models/dispute_priority_enum.dart';

class DisputeResolutionRaiseView extends StatefulWidget {
  const DisputeResolutionRaiseView({
    super.key,
    required this.transactionId,
  });
  final String? transactionId;

  @override
  State<DisputeResolutionRaiseView> createState() =>
      _DisputeResolutionRaiseViewState();
}

class _DisputeResolutionRaiseViewState
    extends State<DisputeResolutionRaiseView> {
  late TextEditingController _transactionIdController,
      _priorityController,
      _reasonController,
      _extrasController;

  @override
  void initState() {
    super.initState();
    _transactionIdController =
        TextEditingController(text: widget.transactionId);
    _priorityController = TextEditingController();
    _reasonController = TextEditingController();
    _extrasController = TextEditingController();
  }

  @override
  void dispose() {
    _transactionIdController.dispose();
    _priorityController.dispose();
    _reasonController.dispose();
    _extrasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Dispute Resolution',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'Manage disputes with vendors by creating a dispute thread here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(40),
            LabelTextField(
              controller: _transactionIdController,
              readOnly: true,
              label: 'Reference code / Transaction ID',
            ),
            const Height(24),
            CustomDropdown(
              textController: _priorityController,
              items: DisputePriority.values.map((value) {
                return CustomDropdownEntry(
                  value.index,
                  value.name.capitalize(),
                );
              }).toList(),
              label: 'Priority',
              hintText: '',
            ),
            const Height(24),
            LabelTextField(
              controller: _reasonController,
              label: 'Reason for filing a dispute',
              hintText: 'Pair of white Air Jordans from Yo...',
            ),
            const Height(24),
            LabelTextField(
              controller: _extrasController,
              label: 'Type in the box below',
              hintText:
                  'Hello my balance, this sneakers is not white o. It is black.',
              isDescription: true,
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: ListenableBuilder(
                  listenable: Listenable.merge(
                    [
                      _priorityController,
                      _reasonController,
                    ],
                  ),
                  builder: (context, child) {
                    return ElevatedButton(
                      onPressed: _priorityController.text.isEmpty ||
                              _reasonController.text.isEmpty
                          ? null
                          : () {},
                      child: const Text('Submit'),
                    );
                  }),
            ),
            const Height(84)
          ],
        ),
      ),
    );
  }
}
