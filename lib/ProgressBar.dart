// import 'package:flutter/material.dart';
// import 'package:timelines/timelines.dart';
//
// class ProgressBar extends StatefulWidget {
//   const ProgressBar({super.key});
//
//   @override
//   State<ProgressBar> createState() => _ProgressBarState();
// }
//
// class _ProgressBarState extends State<ProgressBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Progress Bar Demo'),
//       ),
//       // body: Timeline.tileBuilder(
//       //   builder: TimelineTileBuilder.fromStyle(
//       //     contentsAlign: ContentsAlign.alternating,
//       //     contentsBuilder: (context, index) => Padding(
//       //       padding: const EdgeInsets.all(24.0),
//       //       child: Text('Timeline Event $index'),
//       //     ),
//       //     itemCount: 10,
//       //   ),
//       // ),
//       body: ListView(
//         children: [
//           TimelineTile(
//             oppositeContents: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('opposite\ncontents'),
//             ),
//             contents: Card(
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('contents'),
//               ),
//             ),
//             node: const TimelineNode(
//               indicator: DotIndicator(),
//               startConnector: SolidLineConnector(),
//               endConnector: SolidLineConnector(),
//             ),
//           ),
//           TimelineTile(
//             oppositeContents: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('opposite\ncontents'),
//             ),
//             contents: Card(
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('contents'),
//               ),
//             ),
//             node: const TimelineNode(
//               indicator: DotIndicator(),
//               startConnector: SolidLineConnector(),
//               endConnector: SolidLineConnector(),
//             ),
//           ),
//           TimelineTile(
//             oppositeContents: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('opposite\ncontents'),
//             ),
//             contents: Card(
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('contents'),
//               ),
//             ),
//             node: const TimelineNode(
//               indicator: DotIndicator(),
//               startConnector: SolidLineConnector(),
//               endConnector: SolidLineConnector(),
//             ),
//           ),
//           TimelineTile(
//             oppositeContents: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text('opposite\ncontents'),
//             ),
//             contents: Card(
//               child: Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('contents'),
//               ),
//             ),
//             node: const TimelineNode(
//               indicator: DotIndicator(),
//               startConnector: SolidLineConnector(),
//               endConnector: SolidLineConnector(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
