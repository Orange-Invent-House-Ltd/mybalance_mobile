import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybalanceapp/core/utils/validators.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/custom_dropdown.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/overlay_loading.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../models/dispute_priority_enum.dart';
import 'provider/dispute_provider.dart';

class DisputeResolutionRaiseView extends ConsumerStatefulWidget {
  const DisputeResolutionRaiseView({
    super.key,
    required this.transactionId,
  });
  final String? transactionId;

  @override
  ConsumerState<DisputeResolutionRaiseView> createState() =>
      _DisputeResolutionRaiseViewState();
}

class _DisputeResolutionRaiseViewState
    extends ConsumerState<DisputeResolutionRaiseView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _transactionIdController,
      _priorityController,
      _reasonController,
      _extrasController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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

  bool _isLoading = false;

  void _tryCreateDispute(
    String trxID,
    String priority,
    String reason,
    String description,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(disputeNotifierProvider.notifier).create(
            trxId: trxID,
            priority: priority,
            reason: reason,
            description: description,
          );

      if (mounted) {
        Navigator.of(context).pop(); // go back after successful creation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispute submitted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit dispute: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Dispute Resolution',
      ),
      body: OverlayLoading(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
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
                  validator: Validator.notEmptyValidator,
                  label: 'Reason for filing a dispute',
                  hintText: 'Pair of white Air Jordans from Yo...',
                ),
                const Height(24),
                LabelTextField(
                  controller: _extrasController,
                  validator: Validator.notEmptyValidator,
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
                              : () {
                                  _tryCreateDispute(
                                    _transactionIdController.text,
                                    _priorityController.text,
                                    _reasonController.text,
                                    _extrasController.text,
                                  );
                                },
                          child: const Text('Submit'),
                        );
                      }),
                ),
                const Height(84)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
