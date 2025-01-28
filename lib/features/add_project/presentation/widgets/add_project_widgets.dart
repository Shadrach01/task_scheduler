import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:task_scheduler/core/commons/helper/navigator.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/image_res.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/add_project/presentation/controller/task_input_controller.dart';
import 'package:task_scheduler/features/add_project/presentation/widgets/project_details_tile.dart';
import 'package:task_scheduler/features/add_project/presentation/widgets/task_group_tile.dart';
import 'package:task_scheduler/features/add_project/provider/task_notifier_provider.dart';

class AddProjectWidgets extends ConsumerStatefulWidget {
  const AddProjectWidgets({super.key});

  @override
  ConsumerState<AddProjectWidgets> createState() => _AddProjectWidgetsState();
}

class _AddProjectWidgetsState extends ConsumerState<AddProjectWidgets> {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Office Project",
      "icon": "IconlyBold.work", // Store as string
      "color": Colors.deepOrange
    },
    {
      "name": "Personal Projects",
      "icon": "IconlyBold.profile", // Store as string
      "color": Colors.blue
    },
    {
      "name": "Health & Fitness",
      "icon": "IconlyBold.heart", // Store as string
      "color": Colors.green
    },
    {
      "name": "Study",
      "icon": "IconlyBold.document", // Store as string
      "color": Colors.cyan,
    },
    {
      "name": "Shopping & Errands",
      "icon": "IconlyBold.bag", // Store as string
      "color": Colors.pink,
    },
    {
      "name": "Family",
      "icon": "IconlyBold.user_3", // Store as string
      "color": Colors.brown,
    },
    {
      "name": "Finance",
      "icon": "IconlyBold.wallet", // Store as string
      "color": Colors.amber,
    },
    {
      "name": "Meetings",
      "icon": "IconlyBold.video", // Store as string
      "color": Colors.red,
    },
    {
      "name": "Hobbies",
      "icon": "IconlyBold.discovery", // Store as string
      "color": Colors.indigo,
    },
    {
      "name": "Others",
      "icon": "IconlyBold.category", // Store as string
      "color": Colors.lime,
    },
  ];

  String selectedCategory = "Office Projects"; // Default selected category
  IconData selectedIcon = IconlyBold.work; // Default icon
  Color selectedColor = Colors.blue; // Default color

  // Selected date by default set to the current date
  DateTime selectedDate = DateTime.now();

  // Start Date
  DateTime startDate = DateTime.now();

  // End Date
  DateTime endDate = DateTime.now();

//Formatted date
  String formattedDate = '';

  // Formatted start date
  String formattedStartDate = '';

  // Formatted end date
  String formattedEndDate = '';

  // Default current time for start and end time
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  // Formatted time
  String formattedStartTime = '';
  String formattedEndTime = '';

  final TaskInputController _controller = TaskInputController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize formatted times and dates after context is available
    formattedStartDate = DateFormat('dd MMM yyyy').format(startDate);
    formattedEndDate = DateFormat('dd MMM yyyy').format(endDate);
    formattedStartTime = startTime.format(context);
    formattedEndTime = endTime.format(context);
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight,
      width: appWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageRes.backgroundColor),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: appWidth * .03),
      child: SingleChildScrollView(
        child: Column(
          spacing: appHeight * .035,
          children: [
            // App Bar
            _appBar(context),

            // Add task tile
            TaskGroupTile(
              leading: Container(
                height: appHeight * .04,
                width: appWidth * .09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedColor.withOpacity(.3),
                ),
                child: Icon(
                  selectedIcon,
                  color: selectedColor,
                ),
              ),
              title: "Task Group",
              subTitle: selectedCategory,
              onArrowPressed: () =>
                  _showCategoryDropdown(context, appWidth, appHeight),
            ),

            // Project Name
            ProjectDetailsTile(
              containerTitle: 'Task Name',
              controller: _controller.taskNameController,
              onChanged: (value) => ref
                  .read(inputTaskDetailsNotifierProvider.notifier)
                  .onTaskNameUpdated(value),
            ),

            // Project details
            ProjectDetailsTile(
              containerTitle: 'Description',
              controller: _controller.taskDescriptionController,
              onChanged: (value) => ref
                  .read(inputTaskDetailsNotifierProvider.notifier)
                  .onTaskDescriptionUpdated(value),
            ),

            //Start Date and time
            Row(
              spacing: appWidth * .025,
              children: [
                _startDateAndTime(
                  appHeight,
                  "Start Date",
                  formattedStartDate,
                  () => _showDateDropDown(context, true),
                ),
                _startDateAndTime(
                  appHeight,
                  "Start time",
                  formattedStartTime,
                  () => _showTimePicker(context, true),
                ),
              ],
            ),

            //End Date and time
            Row(
              spacing: appWidth * .025,
              children: [
                _startDateAndTime(
                  appHeight,
                  "End Date",
                  formattedEndDate,
                  () => _showDateDropDown(context, false),
                ),
                _startDateAndTime(
                  appHeight,
                  "End time",
                  formattedEndTime,
                  () => _showTimePicker(context, false),
                ),
              ],
            ),

            SizedBox(height: appHeight * .01),
            AppButton(
              child: Text(
                "Save Task",
                style: AppTextStyle.textStyle(color: Colors.white, size: 20),
              ),
              onTap: () {
                _controller.saveTaskToHiveDB(context, ref);
                AppNavigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dropdown for task group
  void _showCategoryDropdown(
      BuildContext context, double width, double height) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: height * .03,
            horizontal: width * .04,
          ),
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(bottom: width * .035),
                child: GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * .01,
                    children: [
                      Text(
                        category['name'],
                        style: AppTextStyle.textStyle(
                          color: Colors.black87,
                          size: height * .02,
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectedCategory = category['name'];

                      selectedColor = category['color'];

                      // Convert string to IconData and set it
                      selectedIcon = _getIconData(category['icon']);
                    });
                    ref
                        .read(inputTaskDetailsNotifierProvider.notifier)
                        .onTaskGroupSelected(category['name']);

                    ref
                        .read(inputTaskDetailsNotifierProvider.notifier)
                        .onTaskGroupIconSelected(category['icon']);
                    AppNavigator.pop(context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Helper function to convert string to IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "IconlyBold.work":
        return IconlyBold.work;
      case "IconlyBold.profile":
        return IconlyBold.profile;
      case "IconlyBold.heart":
        return IconlyBold.heart;
      case "IconlyBold.document":
        return IconlyBold.document;
      case "IconlyBold.bag":
        return IconlyBold.bag;
      case "IconlyBold.user_3":
        return IconlyBold.user_3;
      case "IconlyBold.wallet":
        return IconlyBold.wallet;
      case "IconlyBold.video":
        return IconlyBold.video;
      case "IconlyBold.discovery":
        return IconlyBold.discovery;
      case "IconlyBold.category":
        return IconlyBold.category;
      default:
        return IconlyBold.work; // Default icon if no match
    }
  }

  // Function to show dropdown for dates
  void _showDateDropDown(
    BuildContext context,
    bool isStartDate,
  ) async {
    DateTime initialDate = isStartDate ? startDate : endDate;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;

          formattedStartDate = DateFormat('dd MMM yyyy').format(startDate);
          ref
              .read(inputTaskDetailsNotifierProvider.notifier)
              .updateStartDate(formattedStartDate);
        } else {
          endDate = pickedDate;
          formattedEndDate = DateFormat('dd MMM yyyy').format(endDate);
          ref
              .read(inputTaskDetailsNotifierProvider.notifier)
              .updateEndDate(formattedEndDate);
        }
        // Update selected date
        selectedDate = pickedDate;
      });
    }
  }

  // Function to show dropdown for time selection
  void _showTimePicker(BuildContext context, bool isStartTime) async {
    TimeOfDay initialTime = isStartTime ? startTime : endTime;

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
          formattedStartTime = startTime.format(context);
          ref
              .read(inputTaskDetailsNotifierProvider.notifier)
              .updateStartTime(formattedStartTime);
        } else {
          endTime = pickedTime;
          formattedEndTime = endTime.format(context);
          ref
              .read(inputTaskDetailsNotifierProvider.notifier)
              .updateEndTime(formattedEndTime);
        }
      });
    }
  }

  // App Bar
  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => AppNavigator.pop(context),
        icon: Icon(IconlyBold.arrow_left),
      ),
      centerTitle: true,
      title: Text(
        "Add Task",
        style: AppTextStyle.textStyle(
          color: Colors.black87,
          size: 20,
          weight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: IMPLEMENT THE NOTIFICATIONS ALARM ICON
          },
          icon: Icon(
            IconlyBold.notification,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Start date and time
  Widget _startDateAndTime(double height, String title, String subTitle,
      VoidCallback onIconPressed) {
    return Expanded(
      child: TaskGroupTile(
        title: title,
        subTitle: subTitle,
        subTitleSize: height * .02,
        onArrowPressed: onIconPressed,
      ),
    );
  }
}
