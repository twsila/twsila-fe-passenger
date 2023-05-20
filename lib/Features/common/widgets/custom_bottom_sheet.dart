import 'package:flutter/material.dart';

abstract class CustomBottomSheet {
  static void displayModalBottomSheet(
      {required BuildContext context,
      bool isDismiss = true,
      required List<Widget> items,
      Color color = Colors.white,
      bool showCloseButton = true,
      bool draggableScrollableSheet = true,
      double initialChildSize = 0.3,
      double minChildSize = 0.1,
      double maxChildSize = 0.94,
      bool enableDrag = true,
      VoidCallback? closeButtonAction}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      isDismissible: isDismiss,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                if (showCloseButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                          if (closeButtonAction != null) closeButtonAction();
                        },
                      ),
                    ],
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: items),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static void displayModalBottomSheetList(
      {required BuildContext context,
      bool isDismiss = true,
      required Widget customWidget,
      Color color = Colors.white,
      bool showCloseButton = true,
      bool draggableScrollableSheet = true,
      double initialChildSize = 0.3,
      double minChildSize = 0.1,
      double maxChildSize = 0.94,
      bool enableDrag = true,
      VoidCallback? closeButtonAction}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      isDismissible: isDismiss,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                if (showCloseButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                          if (closeButtonAction != null) closeButtonAction();
                        },
                      ),
                    ],
                  ),
                Expanded(
                  child: customWidget,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static void heightWrappedBottomSheet(
      {required BuildContext context,
      bool isDismiss = true,
      required List<Widget> items,
      Color color = Colors.white,
      bool showCloseButton = true,
      bool draggableScrollableSheet = true,
      bool enableDrag = true,
      VoidCallback? closeButtonAction}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      isDismissible: isDismiss,
      enableDrag: enableDrag,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.only(top: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (showCloseButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          if (closeButtonAction != null) closeButtonAction();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ...items
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// flexible height according to the child
  static void smallSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      isDismissible: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 6,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(25)),
          ),
          child,
        ],
      ),
    );
  }
}
