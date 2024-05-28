import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reksti/constants.dart';
import 'package:reksti/details/car_detail.dart';
import 'package:reksti/global/car_var.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class ViewDetails extends StatelessWidget {
  static String routeName = "/view";

  const ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ViewDetailsArguments;
    final car = agrs.car;

    List<Appointment> getAppointments() {
      List<Appointment> meetings = <Appointment>[];
      String dateString = car.date.toString();
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      final DateTime today = format.parse(dateString);
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, today.hour, 0, 0);
      final DateTime endTime = startTime.add(const Duration(hours: 1));

      meetings.add(Appointment(
          location: 'Room A',
          startTime: startTime,
          endTime: endTime,
          subject: 'Suspicious Activition Detected!',
          color: const Color(0xFFFF5B5B),
          recurrenceRule: 'FREQ=DAILY;COUNT=1',
          isAllDay: false));

      return meetings;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            car.platNomor,
            style: GoogleFonts.jost(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: whiteColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, DetailsScreen.routeName,
                    arguments: CarDetailsArguments(car: car));
              },
            ),
          ],
        ),
        body: SfCalendar(
          view: CalendarView.day,
          // showNavigationArrow: true,
          dataSource: MeetingDataSource(getAppointments()),
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
          ),
        ));
  }
}

class ViewDetailsArguments {
  final CarsList car;

  ViewDetailsArguments({required this.car});
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
