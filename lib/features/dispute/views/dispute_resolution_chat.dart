import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../models/dispute_resolution_model.dart';
import './widgets/dispute_status_tooltip.dart';

class DisputeResolutionChatView extends StatefulWidget {
  const DisputeResolutionChatView({super.key, required this.id});
  final String? id;

  @override
  State<DisputeResolutionChatView> createState() =>
      _DisputeResolutionChatViewState();
}

class _DisputeResolutionChatViewState extends State<DisputeResolutionChatView> {
  late TextEditingController _messageController;
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! I have a question to ask.',
      'isUser': true,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'text': 'Hey Jamjam, can you please elaborate on your question?',
      'isUser': false,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
    },
    {
      'text': 'How much can I invest in your company?',
      'isUser': true,
      'timestamp': DateTime.now().subtract(const Duration(minutes: 2)),
    },
    {
      'text': 'typing...',
      'isUser': false,
      'isTyping': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  DisputeResolution get dispute =>
      dummyDisputes.firstWhere((dispute) => dispute.id == widget.id);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: dispute.title,
        action: DisputeStatusTooltip(status: dispute.status),
      ),
      body: Column(
        children: [
          Text(
            dispute.description,
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];

                return ChatBubble(message: message);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.b300,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.orange),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData theme = Theme.of(context);
    final bool isUserMessage = message['isUser'] as bool;
    final bool isTyping = message['isTyping'] ?? false;
    return Column(
      crossAxisAlignment:
          isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            isUserMessage ? "You" : "MyBalance",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUserMessage ? AppColors.p400 : Colors.grey[200],
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(8),
              bottomRight: const Radius.circular(8),
              topLeft: !isUserMessage ? Radius.zero : const Radius.circular(8),
              topRight: isUserMessage ? Radius.zero : const Radius.circular(8),
            ),
          ),
          constraints: BoxConstraints(maxWidth: size.width * .75),
          child: isTyping
              ? const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.more_horiz, color: Colors.black54),
                  ],
                )
              : Text(
                  message['text'],
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isUserMessage ? Colors.white : AppColors.b300,
                  ),
                ),
        ),
        if (!isTyping)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              FormatDate.dayTime(message['timestamp']),
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 13.sp, color: AppColors.g200),
            ),
          ),
      ],
    );
  }
}


// class DisputeResolutionChatView extends StatefulWidget {
//   const DisputeResolutionChatView({
//     super.key,
//     required this.id,
//   });
//   final String? id;

//   @override
//   State<DisputeResolutionChatView> createState() =>
//       _DisputeResolutionChatViewState();
// }

// class _DisputeResolutionChatViewState extends State<DisputeResolutionChatView> {
//   late TextEditingController _messageController;

//   @override
//   void initState() {
//     super.initState();
//     _messageController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   DisputeResolution get dispute =>
//       dummyDisputes.firstWhere((dispute) => dispute.id == widget.id);
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       appBar: CustomAppBar(
//         theme: theme,
//         text: dispute.title,
//         action: DisputeStatusTooltip(status: dispute.status),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           children: [
//             Text(
//               dispute.description,
//               style:
//                   theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
//             ),
//             const Divider(),
//             Expanded(
//               child: ListView(
//                 children: const [
//                   SizedBox(height: 16),
//                   DisputeMessage(
//                     message: 'Hello, I have an issue with my payment.',
//                     isUser: false,
//                   ),
//                   DisputeMessage(
//                     message: 'I will look into it and get back to you.',
//                     isUser: true,
//                   ),
//                   DisputeMessage(
//                     message: 'Thank you.',
//                     isUser: false,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }